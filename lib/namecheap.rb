# -*- encoding : utf-8 -*-
module Namecheap
  require File.join(File.dirname(__FILE__), 'namecheap/railtie') if defined?(Rails)
  
  require File.join(File.dirname(__FILE__), 'namecheap/nil_response')
  require File.join(File.dirname(__FILE__), 'namecheap/response')
  require File.join(File.dirname(__FILE__), 'namecheap/domain_check_response')
  require File.join(File.dirname(__FILE__), 'namecheap/domain_check')
  require File.join(File.dirname(__FILE__), 'namecheap/client')
end