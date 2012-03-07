require 'faraday'
require 'faraday_middleware'

module Namecheap
  class Client
    attr_accessor :client, :environment, :username, :key, :client_ip, :verbose

    def initialize(options = {})
      env         =   defined?(Rails) ? Rails.env : :development
      config      =   YAML.load_file(File.join(Rails.root, "config/namecheap.yml"))[env.to_s] rescue nil
      config    ||=   YAML.load_file(File.join(File.dirname(__FILE__), "../generators/templates/namecheap.yml"))[env.to_s] rescue nil

      config.symbolize_keys! if (config)

      self.environment  =   options[:environment] ||  config[:environment]
      self.key          =   options[:key]         ||  config[:key]
      self.username     =   options[:username]    ||  config[:username]
      self.client_ip    =   options[:client_ip]   ||  config[:client_ip]
      self.verbose      =   options[:verbose]     ||  false

      initialize_client
    end

    def is_domain_available?(domain, options = {})
      results     =   domains_available?(domain, options)
      available   =   (results && results.any?) ? results.first.available : false

      return available
    end

    def domains_available?(domains, options = {})
      response    =   domain_check(domains, options)

      return response.results
    end

    def domain_check(domain, options = {})
      domain      =   domain.join(",") if domain.is_a?(Array)
      response    =   perform_query("namecheap.domains.check", {"DomainList" => domain}, options)
      response    =   Namecheap::DomainCheckResponse.new(response)

      return response
    end

    protected
    def initialize_client
      self.client = Faraday.new(:url => api_url, :ssl => {:verify => false}) do |builder|
        builder.request   :url_encoded
        builder.request   :retry
        builder.response  :logger if (self.verbose)
        builder.use       FaradayMiddleware::ParseXml
        builder.adapter   :net_http
      end
    end

    def api_url
      return case self.environment.to_sym
        when :sandbox     then "https://api.sandbox.namecheap.com/xml.response"
        when :production  then "https://api.namecheap.com/xml.response"
        else
          "https://api.sandbox.namecheap.com/xml.response"
      end
    end

    #For API Call details, see http://developer.namecheap.com/docs/doku.php?id=api-reference:domains:check
    def perform_query(api_method, parameters = {}, options = {})
      response    =   nil

      parameters  =   parameters.merge({
        "ApiUser"   =>  self.username,
        "ApiKey"    =>  self.key,
        "UserName"  =>  self.username,
        "ClientIp"  =>  self.client_ip,
        "Command"   =>  api_method
      })

      begin
        log(:info, "[Namecheap::Client] - Sending API Request to Namecheap. Parameters: #{parameters.inspect}. Options: #{options.inspect}")
        response    =   self.client.get do |request|
          request.params    =   parameters
          request.options   =   options if (!options.empty?)
        end
      rescue StandardError => e
        log(:error, "[Namecheap::Client] - Error occurred while trying to check domains. Error Class: #{e.class.name}. Error Message: #{e.message}. Stacktrace: #{e.backtrace.join("\n")}")
        response    =   nil
      end

      return response
    end

    def log(level, message)
      if (self.verbose)
        (defined?(Rails) && Rails.logger) ? Rails.logger.send(level, message) : puts(message)
      end
    end

  end
end

