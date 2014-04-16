require File.expand_path('../../spec_helper', __FILE__)

describe "Namecheap DNS API"  do
  
  describe "update DNS settings for a domain" do
    
    it "should successfully fetch existing DNS records for a given domain" do
      pending "Only run this with a valid connection"
      client      =   init_production_connection
      
      domain      =   'a-real-domain-name.org'
      
      records     =   client.get_dns_records(domain)
    end
    
    it "should successfully update the DNS records for a given domain" do
      pending "Only run this with a valid connection"
      client      =   init_production_connection
      
      domain      =   'a-real-domain-name.org'
      records     =   [{hostname: '@', record_type: 'TXT', address: 'xddadsdsadadsadsadsa', ttl: 1800}]
      
      success     =   client.update_dns_records(domain, records)
      
      success.should == true
    end
  end
  
end