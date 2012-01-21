require 'httparty'

module Namecheap
  class Client
    attr_reader :environment, :username, :key, :client_ip, :verbose

    def initialize(options = {})
      config = YAML.load_file(File.join(Rails.root, "config/namecheap.yml"))[Rails.env] rescue nil
      config ||= YAML.load_file(File.join(File.dirname(__FILE__), "../generators/templates/namecheap.yml"))[Rails.env] rescue nil
      config.symbolize_keys! if (config)
      
      @environment  =   options[:environment] ||  config[:environment]
      @key          =   options[:key]         ||  config[:key]
      @username     =   options[:username]    ||  config[:username]
      @client_ip    =   options[:client_ip]   ||  config[:client_ip]
      @verbose      =   options[:verbose]     ||  false
    end

    def is_domain_available?(domain, max_retries = 0)
      results     =   domains_available?(domain, max_retries)
      available   =   (results && results.any?) ? results.first.available : false
      
      return available
    end
    
    def domains_available?(domains, max_retries = 0)
      response    =   domain_check(domains, max_retries)
      return response.results
    end

    def domain_check(domain, max_retries = 0)
      domain      =   domain.join(",") if domain.is_a?(Array)
      response    =   do_query("namecheap.domains.check", "&DomainList=#{domain}", max_retries)
      response    =   Namecheap::DomainCheckResponse.new(response)
      
      return response
    end

    protected
    def api_url
      return case @environment.to_sym
        when :sandbox     then "https://api.sandbox.namecheap.com"
        when :production  then "https://api.namecheap.com"
        else
          "https://api.sandbox.namecheap.com"
      end
    end
    
    #For API Call details, see http://developer.namecheap.com/docs/doku.php?id=api-reference:domains:check
    def do_query(api_method, options, max_retries = 0)
      response, retries = nil, 0
      query = "#{api_url}/xml.response?ApiUser=#{@username}&ApiKey=#{@key}&UserName=#{@username}&ClientIp=#{@client_ip}&Command=#{api_method}"
      query += options
      
      begin
        log(:info, "[Namecheap::Client] - Sending API Request to Namecheap: #{query}")
        response = HTTParty.get(query)
      rescue Exception => e
        log(:error, "[Namecheap::Client] - Error occurred while trying to check domains. Error Class: #{e.class.name}. Error Message: #{e.message}. Stacktrace: #{e.backtrace.join("\n")}")
        retries += 1
        retry if (retries < max_retries)
      end
      
      return response
    end
    
    def log(level, message)
      if (@verbose)
        (defined?(Rails) && Rails.logger) ? Rails.logger.send(level, message) : puts(message)
      end
    end

  end
end