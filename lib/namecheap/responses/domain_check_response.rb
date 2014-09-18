module Namecheapr
  module Responses
    
    class DomainCheckResponse < Namecheapr::Responses::Response
      attr_accessor :results
    
      def initialize(response)
        super(response)
      
        results = (@success && @command_response && @command_response.has_key?("DomainCheckResult")) ? @command_response["DomainCheckResult"] : nil
      
        if (results && results.is_a?(Hash))
          @results = [DomainCheck.new(results)]
        
        elsif (results && results.is_a?(Array))
          @results = results.collect { |item| DomainCheck.new(item) }
        end
      end

    end
    
  end
end