require File.expand_path('../../spec_helper', __FILE__)

describe Namecheapr::Responses::Response  do
  before(:each) do
    @bad_response_hash = {"ApiResponse"=>{"Status"=>"ERROR", 
            "Errors"=>{"Error"=>"API Key is invalid or API access has not been enabled"}, 
            "GMTTimeDifference"=>"--6:00", 
            "RequestedCommand"=>"namecheap.domains.check", 
            "Server"=>"SERVER159", 
            "ExecutionTime"=>"0.01", 
            "xmlns"=>"http://api.namecheap.com/xml.response"}} 
  end

  it "should return a status" do
    response = Namecheapr::Responses::Response.new(@bad_response_hash)
    response.status.should == :error
  end

  it "should give error message for invalid api key when using an invalid key" do
    response = Namecheapr::Responses::Response.new(@bad_response_hash)
    response.errors.first.message.should include("API Key is invalid")
  end
end