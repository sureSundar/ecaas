class SessionsController < ApplicationController
skip_before_action :check_if_login_is_required
  def new
  end

def create
	 user = User.find_by(name: params[:name])
	 if user != nil and user.account.id == current_account.id and User.authenticate(params[:name], params[:password])
		 session[:user_id] = user.id
   		 redirect_to account_stores_path(account_id: user.account.id)
	 else
		 redirect_to login_url, alert: "Invalid user/password/site combination "
	 end
end

def destroy
	session[:user_id] = nil
	redirect_to login_url, :notice => "Logged out"
end
end
