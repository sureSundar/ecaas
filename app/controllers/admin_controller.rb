class AdminController < ApplicationController
before_action :set_store, only: [:index,:show, :edit, :update, :destroy]

  def index
	session[:store_id] = store.id
  end
  
private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = current_account.stores.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:name, :description, :account_id)
    end  
end
