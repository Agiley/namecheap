Gem::Specification.new do |s|
  s.specification_version     = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5") if s.respond_to? :required_rubygems_version=

  s.name = 'namecheapr'
  s.version = '0.5'

  s.homepage      =   "http://github.com/Agiley/namecheap"
  s.email         =   "sebastian@agiley.se"
  s.authors       =   ["Sebastian Johnsson"]
  s.description   =   "Wrapper for Namecheap API"
  s.summary       =   "Wrapper for Namecheap API"

  s.add_dependency 'faraday', '>= 0.9'
  s.add_dependency 'faraday_middleware', '>= 0.10'
  s.add_dependency 'multi_xml', '>= 0.5.5'
  s.add_dependency 'domainatrix', '>= 0.0.11'

  # = MANIFEST =
 s.files = %w[
 Gemfile
 README.textile
 Rakefile
 lib/generators/namecheapr/namecheapr_generator.rb
 lib/generators/templates/namecheap.yml
 lib/namecheapr.rb
 lib/namecheapr/client.rb
 lib/namecheapr/dns_record.rb
 lib/namecheapr/domain_check.rb
 lib/namecheapr/extensions/hash.rb
 lib/namecheapr/extensions/string.rb
 lib/namecheapr/modules/dns.rb
 lib/namecheapr/modules/domains.rb
 lib/namecheapr/railtie.rb
 lib/namecheapr/responses/dns_records_response.rb
 lib/namecheapr/responses/domain_check_response.rb
 lib/namecheapr/responses/response.rb
 lib/namecheapr/status.rb
 lib/tasks/namecheap_tasks.rake
 namecheapr.gemspec
 spec/namecheap.yml.example
 spec/namecheap/namecheap_dns_spec.rb
 spec/namecheap/namecheap_domain_check_response_spec.rb
 spec/namecheap/namecheap_response_spec.rb
 spec/namecheap/namecheap_spec.rb
 spec/spec_helper.rb
 ]
 # = MANIFEST =

  s.test_files = s.files.select { |path| path =~ %r{^spec/*/.+\.rb} }
end