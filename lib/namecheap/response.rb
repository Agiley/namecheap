module Namecheap
  class Response
    def initialize(response)
      @response = response
    end

    def status
      return (@response.has_key?("ApiResponse") && @response["ApiResponse"].has_key?("Status")) ? @response["ApiResponse"]["Status"] : nil
    end

    def message
      if (@response["ApiResponse"]["Errors"].any?)
        @response["ApiResponse"]["Errors"]["Error"]
      end
    end

    def items
      response = (@response.has_key?("ApiResponse") && @response["ApiResponse"].has_key?("CommandResponse")) ? @response["ApiResponse"]["CommandResponse"] : nil
      response.delete_if { |key, value| key == "Type" } if (response)
    end
  end
end
