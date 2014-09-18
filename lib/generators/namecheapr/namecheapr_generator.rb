require 'generators/helpers/file_helper'

module Namecheapr
  module Generators
    class NamecheapGenerator < Rails::Generators::Base
      namespace "namecheap"
      source_root File.expand_path("../../templates", __FILE__)

      desc "Copies namecheap.yml to the Rails app's config directory."
      
      def copy_config
        template "namecheap.yml", "config/namecheap.yml"
      end
      
    end
  end
end