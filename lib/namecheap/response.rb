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
    attr_accessor :response, :status, :success
    attr_accessor :requested_command, :command_response, :errors, :warnings
    attr_accessor :server, :gmt_time_difference, :execution_time
    
    def initialize(response)
      @response = response
      @response = (@response && @response.has_key?("ApiResponse")) ? @response["ApiResponse"] : nil
      
      if (@response)
        variables = ["CommandResponse", "Status", "RequestedCommand", "Server", "ExecutionTime"]
        variables.each { |variable| set_variable(variable) }
        
        status_variables = ["Errors", "Warnings"]
        status_variables.each { |status_variable| set_status_variable(status_variable) }
          
        set_gmt_time_difference
        
        @status   =   @status.downcase.to_sym
        @success  =   @status.eql?(:success)
      end
    end

    def set_variable(key)
      value = (@response.has_key?(key)) ? @response[key] : nil
      send("#{key.underscore}=", value)
    end
    
    def set_gmt_time_difference
      @gmt_time_difference = (@response.has_key?("GMTTimeDifference")) ? @response["GMTTimeDifference"] : nil
    end
    
    def set_status_variable(key)
      values  =   []
      nodes   =   (@response.has_key?(key) && @response[key] && @response[key].any?) ? @response[key] : []
      
      nodes.each do |type, message|
        values << Namecheap::Status.new(type, message) if (type && message)
      end
      
      send("#{key.underscore}=", values)
    end

  end
end
