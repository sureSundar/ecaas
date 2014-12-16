class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy,:admin]

  # GET /stores
  # GET /stores.json
  def index
      @stores = current_account.stores.find(:all)	
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
	@store = current_account.stores.find(params[:id])
  end
  def admin
	@store = current_account.stores.find(params[:id])
	@products = store.products.find(:all)
	  if @products != nil
        format.html { redirect_to @products, notice: 'Welcome to the store.' }
        format.json { render action: 'show', status: :created, location: @products }
      else
        format.html { render action: 'products#new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
  end
  # GET /stores/new
  def new
    @store = current_account.stores.new
  end

  # GET /stores/1/edit
  def edit
	@store = current_account.stores.find(params[:id])
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to account_stores_path(account_id: current_account.id), notice: 'Store was successfully created.' }
        format.json { render action: 'show', status: :created, location: @store }
      else
        format.html { render action: 'new' }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to account_stores_path(account_id: current_account.id), notice: 'Store was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
	@store = current_account.stores.find(params[:id])
    @store.destroy
    respond_to do |format|
      format.html { redirect_to account_stores_path(account_id: current_account.id) }
      format.json { head :no_content }
    end
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
