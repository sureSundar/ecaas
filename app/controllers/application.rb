before_filter :check_account_status

  protected
    def check_account_status
      unless account_subdomain == default_account_subdomain
        # TODO: this is where we could check to see if the account is active as well (paid, etc...)
        redirect_to default_account_url if current_account.nil? 
      end
    end  