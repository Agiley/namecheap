require File.expand_path('../../spec_helper', __FILE__)

describe Namecheapr::Responses::DomainCheckResponse  do
  
  describe "successful response from namecheap" do
    before(:each) do
    	@domain_check_response_hash = {
    	  "ApiResponse" => 
    	    {"Status"=>"OK", 
    			 "Errors"=>{},  
    			 "CommandResponse" => {
      			   "DomainCheckResult" => [
      		        {"Domain" => "domain1.com", "Available" => "true"},
      		        {"Domain" => "domain2.com", "Available" => "false"},
      		        {"Domain" => "domain.wtf", "Available" => "error", "ErrorNo" => "750", "Description" => "No response from the registry"}
      		      ],
      			 },
      	    "GMTTimeDifference"=>"--6:00", 
      	    "RequestedCommand"=>"namecheap.domains.check", 
      	    "Server"=>"SERVER159", 
      	    "ExecutionTime"=>"0.01", 
      	    "xmlns"=>"http://api.namecheap.com/xml.response"}}

      @response = Namecheapr::Responses::DomainCheckResponse.new(@domain_check_response_hash)
    end

    it "should have a domain check result" do
      @response.results.length.should == 3
    end
    
    it "should be a valid result" do
      @response.status.should == :ok
      @response.success.should be_true
    end

    it "should report that domain1.com is available" do
      @response.results[0].available.should be_true
    end

    it "should report that domain2.com is not available" do
      @response.results[1].available.should be_false
    end

    it "should report errors if there are any" do
      @response.results[2].error.should == "750"
    end

    it "should include a description if there are errors" do
      @response.results[2].description == "No response from the registry"
    end
  end

  describe "failure response from namecheap" do 
    before(:each) do
      @bad_response_hash = {"ApiResponse"=>{"Status"=>"ERROR", 
	      "Errors"=>{"Error"=>"API Key is invalid or API access has not been enabled"}, 
	      "GMTTimeDifference"=>"--6:00", 
	      "RequestedCommand"=>"namecheap.domains.check", 
	      "Server"=>"SERVER159", 
	      "ExecutionTime"=>"0.01", 
	      "xmlns"=>"http://api.namecheap.com/xml.response"}}
       

      it "should return false if bad hash is returned" do
        
      end
    end
  end
end

  #<?xml version="1.0" encoding="utf-8"?>
  # <ApiResponse Status="OK" xmlns="http://api.namecheap.com/xml.response">
  #  <Errors />
  #  <RequestedCommand>namecheap.domains.check</RequestedCommand>
  #  <CommandResponse>
  #    <DomainCheckResult Domain="domain1.com" Available="true" />
  #    <DomainCheckResult Domain="availabledomain.com" Available="false" />
  #    <DomainCheckResult Domain="err.tld" Available="error" ErrorNo="750" Description="No response from the registry" />
  #  </CommandResponse>
  #  <Server>SERVER-NAME</Server>
  #  <GMTTimeDifference>+5</GMTTimeDifference>
  #  <ExecutionTime>32.76</ExecutionTime>
  #</ApiResponse>