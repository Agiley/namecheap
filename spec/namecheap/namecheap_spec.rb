require File.expand_path('../../spec_helper', __FILE__)

describe "NamecheapAPI Wrapper"  do
  describe "initializating settings" do

    describe "with defaults" do
      it "should contain a username" do
        namecheap = Namecheap::Client.new
        namecheap.send(:username).should == 'apiuser'
      end

      it "should contain a key" do
        namecheap = Namecheap::Client.new
        namecheap.send(:key).should == 'apikey'
      end

      it "should contain a client_ip" do
        namecheap = Namecheap::Client.new
        namecheap.send(:client_ip).should == '127.0.0.1'
      end
    end

    describe "with defaults overidden" do

      it "shoud contain a overidden username" do
        namecheap = Namecheap::Client.new(:username => 'testuser')
        namecheap.send(:username).should == 'testuser'
      end

      it "shoud contain a key" do
        namecheap = Namecheap::Client.new(:key => 'testkey')
        namecheap.send(:key).should == 'testkey'
      end

      it "shoud contain a client_ip" do
        namecheap = Namecheap::Client.new(:client_ip => '66.11.22.44')
        namecheap.send(:client_ip).should == '66.11.22.44'
      end
    end
  end

  describe "Attempt to connect with bad credentials" do
    it "should report an error on erroneous account information" do
      namecheap = Namecheap::Client.new
      response = namecheap.domain_check("fakedomain")
      response.status.should == :error
      response.success.should be_false
    end

    it "should give error message for invalid api key when using an invalid key" do
      namecheap = Namecheap::Client.new
      response = namecheap.domain_check("fakedomain")
      response.status.should == :error
      response.success.should be_false
      response.errors.first.message.should include("API Key is invalid")
    end
  end

  describe "Attempt to connect with valid credentials" do
  end

  describe "#domain_check" do
    it "should build query with multiple domains" do
      namecheap = Namecheap::Client.new
      namecheap.expects(:perform_query).with("namecheap.domains.check", {"DomainList" => "domain1.com,domain2.com"}, {})
      namecheap.domain_check(['domain1.com','domain2.com'])
    end
  end

  describe "#is_domain_available?" do
    it "should return false if connection fails" do
      namecheap = Namecheap::Client.new(:apikey => 'BADKEY')
      namecheap.is_domain_available?('fakedomain.tld').should == false
    end

    it "should return true if connections succeeds and domain is available" do
      pending "Need API Access To Namecheap.com"
      namecheap = Namecheap::Client.new
      namecheap.is_domain_available?('saucytuborswithashoefetish.com').should be_true
    end

    it "should return false if connections succeeds and domain is not available" do
      namecheap = Namecheap::Client.new
      namecheap.is_domain_available?('hashrocket.com').should == false

      #To test behind a proxy:
      #namecheap.is_domain_available?('hashrocket.com', :proxy => {:uri => URI('http://proxy.com:1234')})
    end
  end
end

