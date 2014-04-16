module Namecheap
  module Modules
    module Domains
      
      def is_domain_available?(domain, options = {})
        results     =   domains_available?(domain, options)
        available   =   (results && results.any?) ? results.first.available : nil

        return available
      end

      def domains_available?(domains, options = {})
        response    =   domain_check(domains, options)

        return response.results
      end

      def domain_check(domain, options = {})
        domain      =   domain.join(",") if domain.is_a?(Array)
        response    =   perform_query("namecheap.domains.check", {"DomainList" => domain}, options)
        response    =   Namecheap::Responses::DomainCheckResponse.new(response)

        return response
      end
      
    end
  end
end