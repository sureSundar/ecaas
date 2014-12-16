class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SubdomainAccounts
  layout :current_layout_name # sets the proper layout, for promo_site or application
  before_action :check_if_login_is_required 

  protected
    def login_required
		unless User.find_by(id: session[:user_id])
			redirect_to login_url, notice: "Please log in"
		end
	end
    def promo_site?
      account_subdomain == default_account_subdomain
    end

    def current_layout_name
      promo_site? ? 'promo_site' : 'application'
    end    

    def check_if_login_is_required
      login_required unless promo_site?
    end

private
	def current_cart
		Cart.find(session[:cart_id])
		rescue ActiveRecord::RecordNotFound
		cart = Cart.create
		session[:cart_id] = cart.id
		cart
	end  
end
