module Namecheap
  class DomainCheckResponse < Namecheap::Response
    def items
      results = super ? super["DomainCheckResult"] : nil
      
      if (results && results.is_a?(Hash))
        results = [DomainCheck.new(results)]
      elsif (results && results.is_a?(Array))
        results = results.collect {|item| DomainCheck.new(item) }
      end

      return results
    end
  end
end