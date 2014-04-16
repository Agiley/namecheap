module Namecheap
  module Responses
    
    class DnsRecordsResponse < Namecheap::Responses::Response
      attr_accessor :results
    
      def initialize(response)
        super(response)
      
        results       =   (@success && @command_response && @command_response.has_key?("DomainDNSGetHostsResult")) ? @command_response["DomainDNSGetHostsResult"]["host"] : nil
        
        if (results && results.is_a?(Hash))
          @results    =   [DnsRecord.new(results)]
        
        elsif (results && results.is_a?(Array))
          @results    =   results.collect { |item| DnsRecord.new(item) }
        end
      end
      
      def to_array
        records       =   []
        
        @results.each do |result|
          records    <<   result.to_hash
        end if @results && @results.any?
        
        return records
      end

    end
    
  end
end