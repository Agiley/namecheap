module Namecheap
  class DomainCheckResponse < Namecheap::Response
    def items
      results = super["DomainCheckResult"]
      return (results.is_a?(Hash)) ? [DomainCheck.new(results)] : results.collect {|item| DomainCheck.new(item) } 
    end
  end
end