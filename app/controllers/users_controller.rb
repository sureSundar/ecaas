class UsersController < ApplicationController
  skip_before_action :check_if_login_is_required
  before_action :set_user, only: [:show, :edit, :update, :destroy]
	
  # GET /users
  # GET /users.json
def index
@users = current_account.users.order(:name)
	respond_to do |format|
		format.html # index.html.erb
		format.xml { render :xml => @users }
	end
end
  # GET /users/1
  # GET /users/1.json
  def show
	@user = current_account.users.find(params[:id])
  end

  # GET /users/new
  def new
    @user = current_account.users.new
  end

  # GET /users/1/edit
  def edit
	@user = current_account.users.find(params[:id])
  end

  # POST /users
  # POST /users.json
def create
	@user = User.new(user_params)
	respond_to do |format|
		if @user.save
			format.html { redirect_to(account_users_path,:notice => "User #{@user.name} was successfully created." ) }
			format.xml { render :xml => @user,	:status => :created, :location => @user }
		else
			format.html { render :action => "new" }
			format.xml { render :xml => @user.errors,:status => :unprocessable_entity }
		end
	end
end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
def update
	@user = User.find(params[:id])
	respond_to do |format|
		if @user.update_attributes(params[:user])
			format.html { redirect_to(users_url,	:notice => "User #{@user.name} was successfully updated." ) }
			format.xml { head :ok }
		else
			format.html { render :action => "edit" }
			format.xml { render :xml => @user.errors,	:status => :unprocessable_entity }
		end
	end
end
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      #params.require(:user).permit(:name, :hashed_password, :salt, :account_id)
	  params.require(:user).permit(:name, :password, :password_confirmation, :account_id)
    end
end
