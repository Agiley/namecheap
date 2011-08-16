module Namecheap
  class DomainCheckResponse < Namecheap::Response
    def items
      super.collect {|item| DomainCheck.new(item[1])} 
    end
  end
end