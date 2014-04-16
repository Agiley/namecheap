$LOAD_PATH << "." unless $LOAD_PATH.include?(".")

begin
  require "rubygems"
  require "bundler"

  if Gem::Version.new(Bundler::VERSION) <= Gem::Version.new("0.9.5")
    raise RuntimeError, "Your bundler version is too old." +
     "Run `gem install bundler` to upgrade."
  end

  # Set up load paths for all bundled gems
  Bundler.setup
rescue Bundler::GemNotFound
  raise RuntimeError, "Bundler couldn't find some gems." +
    "Did you run \`bundlee install\`?"
end

Bundler.require

require File.expand_path('../../lib/namecheap', __FILE__)

RSpec.configure do |config|
  config.mock_with :mocha
end

def load_config
  config = YAML.load_file((File.exists?('./spec/namecheap.yml')) ? './spec/namecheap.yml' : './spec/namecheap.yml.example')
  config.symbolize_keys!
end

def init_production_connection
  config = load_config  
  Namecheap::Client.new(config[:production])
end