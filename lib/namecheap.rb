# -*- encoding : utf-8 -*-
module Namecheap
  require File.join(File.dirname(__FILE__), 'namecheap/railtie') if defined?(Rails)
  
  require File.join(File.dirname(__FILE__), 'namecheap/status')
  require File.join(File.dirname(__FILE__), 'namecheap/response')
  require File.join(File.dirname(__FILE__), 'namecheap/domain_check_response')
  require File.join(File.dirname(__FILE__), 'namecheap/domain_check')
  require File.join(File.dirname(__FILE__), 'namecheap/client')
  
  MultiXml.parser = :rexml if defined?(JRUBY_VERSION) #There's currently a bug with JRUBY 1.6.5/1.6.6/1.7 and HTTParty + Nokogiri
end