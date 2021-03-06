  #
  # Inspired by
  # http://dev.rubyonrails.org/svn/rails/plugins/account_location/lib/account_location.rb
  #
  module SubdomainAccounts  
    def self.included( controller )
      controller.helper_method(:account_domain, :account_subdomain, :account_url, :current_account, :default_account_subdomain, :default_account_url)
    end

    protected

      # TODO: need to handle www as well
      def default_account_subdomain
        ''
      end

      def account_url( account_subdomain = default_account_subdomain, use_ssl = request.ssl? )
        http_protocol(use_ssl) + account_host(account_subdomain)
      end

      def account_host( subdomain )
        account_host = ''
        account_host << subdomain + '.'
        account_host << account_domain
      end

      def account_domain
        account_domain = ''
        account_domain << request.domain + request.port_string
      end

      def account_subdomain
        request.subdomains.first || ''

      end

      def default_account_url( use_ssl = request.ssl? )
        http_protocol(use_ssl) + account_domain
      end

      def current_account
        if (Account.find_by_subdomain(account_subdomain) != nil)
			Account.find_by_subdomain(account_subdomain) 
		else
			Account.find_by_id(params[:account_id])
		end
      end

      def http_protocol( use_ssl = request.ssl? )
        (use_ssl ? "https://" : "http://")
      end
	
  end  