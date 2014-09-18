module Namecheapr
  class DomainCheck
    attr_accessor :domain, :available, :error, :description

    def initialize(item)
      @domain         =   item["Domain"]
      
      @available      =   case item["Available"].downcase
        when "true"   then  true
        when "false"  then  false
        when "error"  then  nil
        else
          nil
      end
      
      @error          =   item["ErrorNo"]
      @description    =   item["Description"]
    end
  end
end