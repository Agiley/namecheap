namespace :namecheap do
  
  task :check_if_domain_is_available, [:domain] => [:environment] do |task, args|
    domain = args.domain
    
    client = Namecheapr::Client.new
    available = client.is_domain_available?(domain)
    
    puts "Domain '#{domain}' available? #{available.inspect}"
  end
  
end