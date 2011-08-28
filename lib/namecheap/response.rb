module Namecheap
  class Response
    def initialize(response)
      @response = response
    end

    def status
      @response["ApiResponse"]["Status"] rescue nil
    end

    def message
      if (@response["ApiResponse"]["Errors"].any?)
        @response["ApiResponse"]["Errors"]["Error"]
      end
    end

    def items
      response = @response["ApiResponse"]["CommandResponse"] rescue nil
      response.delete_if { |key, value| key == "Type" } if (response)
    end
  end
end
