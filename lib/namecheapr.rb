# -*- encoding : utf-8 -*-
module Namecheapr
  VERSION = "0.5"

  require File.join(File.dirname(__FILE__), 'namecheapr/railtie') if defined?(Rails)

  if (!String.instance_methods(false).include?(:underscore))
    require File.join(File.dirname(__FILE__), 'namecheapr/extensions/string')
  end

  if (!Hash.instance_methods(false).include?("symbolize_keys!"))
    require File.join(File.dirname(__FILE__), 'namecheapr/extensions/hash')
  end

  require File.join(File.dirname(__FILE__), 'namecheapr/status')
  require File.join(File.dirname(__FILE__), 'namecheapr/responses/response')
  require File.join(File.dirname(__FILE__), 'namecheapr/responses/domain_check_response')
  require File.join(File.dirname(__FILE__), 'namecheapr/responses/dns_records_response')
  require File.join(File.dirname(__FILE__), 'namecheapr/domain_check')
  require File.join(File.dirname(__FILE__), 'namecheapr/dns_record')
  require File.join(File.dirname(__FILE__), 'namecheapr/modules/domains')
  require File.join(File.dirname(__FILE__), 'namecheapr/modules/dns')
  require File.join(File.dirname(__FILE__), 'namecheapr/client')
end

