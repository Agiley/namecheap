# -*- encoding : utf-8 -*-
module Namecheap
  VERSION = "0.1"

  require File.join(File.dirname(__FILE__), 'namecheap/railtie') if defined?(Rails)

  if (!String.instance_methods(false).include?(:underscore))
    require File.join(File.dirname(__FILE__), 'namecheap/extensions/string')
  end

  if (!Hash.instance_methods(false).include?("symbolize_keys!"))
    require File.join(File.dirname(__FILE__), 'namecheap/extensions/hash')
  end

  require File.join(File.dirname(__FILE__), 'namecheap/status')
  require File.join(File.dirname(__FILE__), 'namecheap/response')
  require File.join(File.dirname(__FILE__), 'namecheap/domain_check_response')
  require File.join(File.dirname(__FILE__), 'namecheap/domain_check')
  require File.join(File.dirname(__FILE__), 'namecheap/client')
end

