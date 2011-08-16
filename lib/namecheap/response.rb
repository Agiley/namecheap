module Namecheap
  class Response
    def initialize(response)
      @response = response
    end

    def status
      @response["ApiResponse"]["Status"] 
    end

    def message
      if @response["ApiResponse"]["Errors"].any?
        @response["ApiResponse"]["Errors"]["Error"]
      end
    end

    def items
      response = @response["ApiResponse"]["CommandResponse"]
      raise Namecheap::NilResponse if response.nil?
      response.delete_if { |key, value| key == "Type" }
    end
  end
end
