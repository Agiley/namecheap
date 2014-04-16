module Namecheap
  class DnsRecord
    attr_accessor :host_id, :hostname, :record_type, :address, :mx_pref, :ttl

    def initialize(item)
      @host_id        =   item["HostId"]
      @hostname       =   item["Name"]
      @record_type    =   item["Type"]
      @address        =   item["Address"]
      @mx_pref        =   item["MXPref"]
      @ttl            =   item["TTL"]
      
      @error          =   item["ErrorNo"]
      @description    =   item["Description"]
    end
    
    def to_hash
      instance_variables.each_with_object({}) { |var, hash| hash[var.to_s.delete("@").to_sym] = instance_variable_get(var) }
    end
    
  end
end