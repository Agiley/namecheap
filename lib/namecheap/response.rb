#Example response. For more info regarding the API call, see http://developer.namecheap.com/docs/doku.php?id=api-reference:domains:check
#<?xml version="1.0" encoding="utf-8"?>
#<ApiResponse Status="OK" xmlns="http://api.namecheap.com/xml.response">
#  <Errors />
#  <RequestedCommand>namecheap.domains.check</RequestedCommand>
#  <CommandResponse Type="namecheap.domains.check">
#    <DomainCheckResult Domain="domain1.com" Available="true" />
#    <DomainCheckResult Domain="availabledomain.com" Available="false" />
#  </CommandResponse>
#  <Server>SERVER-NAME</Server>
#  <GMTTimeDifference>+5</GMTTimeDifference>
#  <ExecutionTime>32.76</ExecutionTime>
#</ApiResponse>

module Namecheap
  class Response
    def initialize(response)
      @response = response
    end

    def status
      return (@response && @response.has_key?("ApiResponse") && @response["ApiResponse"].has_key?("Status")) ? @response["ApiResponse"]["Status"] : nil
    end

    def message
      if (@response && @response.has_key?("ApiResponse") && @response["ApiResponse"].has_key?("Errors") && @response["ApiResponse"]["Errors"].any?)
        @response["ApiResponse"]["Errors"]["Error"]
      end
    end

    def items
      response = (@response && @response.has_key?("ApiResponse") && @response["ApiResponse"].has_key?("CommandResponse")) ? @response["ApiResponse"]["CommandResponse"] : nil
      response.delete_if { |key, value| key == "Type" } if (response)
      return response
    end
  end
end
