require File.expand_path('../../spec_helper', __FILE__)

describe "NamecheapAPI Wrapper"  do
  describe "initializating settings" do

    describe "with defaults" do
      it "should contain a username" do
        client = Namecheap::Client.new
        client.send(:username).should == 'apiuser'
      end

      it "should contain a key" do
        client = Namecheap::Client.new
        client.send(:key).should == 'apikey'
      end

      it "should contain a client_ip" do
        client = Namecheap::Client.new
        client.send(:client_ip).should == '127.0.0.1'
      end
    end

    describe "with defaults overidden" do

      it "shoud contain a overidden username" do
        client = Namecheap::Client.new(:username => 'testuser')
        client.send(:username).should == 'testuser'
      end

      it "shoud contain a key" do
        client = Namecheap::Client.new(:key => 'testkey')
        client.send(:key).should == 'testkey'
      end

      it "shoud contain a client_ip" do
        client = Namecheap::Client.new(:client_ip => '66.11.22.44')
        client.send(:client_ip).should == '66.11.22.44'
      end
    end
  end

  describe "Attempt to connect with bad credentials" do
    it "should report an error on erroneous account information" do
      client = Namecheap::Client.new
      response = client.domain_check("fakedomain")
      response.status.should == :error
      response.success.should be_false
    end

    it "should give error message for invalid api key when using an invalid key" do
      client = Namecheap::Client.new
      response = client.domain_check("fakedomain")
      response.status.should == :error
      response.success.should be_false
      response.errors.first.message.should include("API Key is invalid")
    end
  end

  describe "#is_domain_available?" do
    it "should return nil if connection fails" do
      client = Namecheap::Client.new(:apikey => 'BADKEY')
      client.is_domain_available?('fakedomain.tld').should == nil
    end

    it "should return true if connections succeeds and domain is available" do
      client = init_production_connection
      client.is_domain_available?('ketchupmayonaiisemfakkrr.com').should be_true
    end

    it "should return false if connections succeeds and domain is not available" do
      client = init_production_connection
      client.is_domain_available?('hashrocket.com').should == false

      #To test behind a proxy:
      #client.is_domain_available?('hashrocket.com', :proxy => {:uri => URI('http://proxy.com:1234')})
    end
  end
end

