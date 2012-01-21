module Namecheap
  class DomainCheck
    attr_accessor :domain, :available, :error, :description

    def initialize(item)
      @domain       =   item["Domain"]
      @available    =   (item["Available"] == "true") ? true : false
      @error        =   item["ErrorNo"]
      @description  =   item["Description"]
    end
  end
end