module Namecheap
  module Modules
    module Dns
      
      def get_dns_records(domain, connection_options = {})
        params            =   generate_domain_params(domain)
        
        response          =   perform_query("namecheap.domains.dns.getHosts", params, connection_options)
        response          =   Namecheap::Responses::DnsRecordsResponse.new(response)
        
        records           =   response.to_array
      end
      
      def update_dns_records(domain, records = [], options = {}, connection_options = {})
        fetch_records     =   options.fetch(:fetch_records,   true)
        default_ttl       =   options.fetch(:default_ttl,     1800)
        default_mx_pref   =   options.fetch(:default_mx_pref, 10)
        
        if (fetch_records)
          existing_records    =   get_dns_records(domain, connection_options)
          records             =   records | existing_records
        end
        
        params            =   generate_domain_params(domain)
        
        records.each_with_index do |record, index|
          record          =   record.symbolize_keys!
          
          if (record && record.has_key?(:hostname) && record.has_key?(:record_type) && record.has_key?(:address))
            index        +=   1
          
            params["HostName#{index}"]      =   record[:hostname]
            params["RecordType#{index}"]    =   record[:record_type]
            params["Address#{index}"]       =   record[:address]
            params["MXPref#{index}"]        =   record.fetch(:mx_pref,    default_mx_pref)
            params["EmailType"]             =   record.fetch(:email_type, "") if [:mx, :mxe].include?(record[:record_type].downcase.to_sym)
            params["TTL#{index}"]           =   record.fetch(:ttl,        default_ttl)
          end
        end
        
        response          =   perform_query("namecheap.domains.dns.setHosts", params, connection_options)
        response          =   Namecheap::Responses::Response.new(response)
        success           =   (response.success && response.command_response && response.command_response.has_key?("DomainDNSSetHostsResult")) ? response.command_response["DomainDNSSetHostsResult"]["IsSuccess"].downcase.eql?('true') : nil

        return success
      end
      
      protected
      def generate_domain_params(domain)
        parsed            =   Domainatrix.parse(domain)
        sld               =   parsed.domain
        tld               =   parsed.public_suffix
        
        params            =   {
          "SLD"     =>    sld,
          "TLD"     =>    tld,
        }
        
        return params
      end
      
    end
  end
end