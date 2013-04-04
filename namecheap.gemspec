Gem::Specification.new do |s|
  s.specification_version     = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5") if s.respond_to? :required_rubygems_version=

  s.name = 'namecheap'
  s.version = '0.2'

  s.homepage      =   "http://github.com/Agiley/namecheap"
  s.email         =   "sebastian@agiley.se"
  s.authors       =   ["Sebastian Johnsson"]
  s.description   =   "Wrapper for Namecheap API"
  s.summary       =   "Wrapper for Namecheap API"

  s.add_dependency "faraday", ">= 0.8"
  s.add_dependency "faraday_middleware", ">= 0.9.0"
  s.add_dependency "multi_xml", ">= 0.5"

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'mocha'

  # = MANIFEST =
 s.files = %w[
 Gemfile
 README.textile
 Rakefile
 lib/generators/namecheap/namecheap_generator.rb
 lib/generators/templates/namecheap.yml
 lib/namecheap.rb
 lib/namecheap/client.rb
 lib/namecheap/domain_check.rb
 lib/namecheap/domain_check_response.rb
 lib/namecheap/extensions/hash.rb
 lib/namecheap/extensions/string.rb
 lib/namecheap/railtie.rb
 lib/namecheap/response.rb
 lib/namecheap/status.rb
 lib/tasks/namecheap_tasks.rake
 namecheap.gemspec
 spec/namecheap/namecheap_domain_check_response_spec.rb
 spec/namecheap/namecheap_response_spec.rb
 spec/namecheap/namecheap_spec.rb
 spec/spec_helper.rb
 ]
 # = MANIFEST =

  s.test_files = s.files.select { |path| path =~ %r{^spec/*/.+\.rb} }
end

