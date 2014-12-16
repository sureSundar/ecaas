class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = current_account.stores.find(params[:store_id]).products.all
	@cart = current_cart
  end

  def search
    @products = current_account.stores.find(params[:store_id]).products.where("title like ?","%#{params[:q]}%").all
	#where("title = ?",params[:q]).load
	@cart = current_cart
	render "products/index"	
	#redirect_to account_store_products_path(store_id: params[:store_id],account_id: params[:account_id])
  end

  # GET /products/1
  # GET /products/1.json
  def show
	@product = current_account.stores.find(params[:store_id]).products.find(params[:id])
  end

  # GET /products/new
  def new
    @product = current_account.stores.find(params[:store_id]).products.new
  end

  # GET /products/1/edit
  def edit
	@product = current_account.stores.find(params[:store_id]).products.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        #format.html { redirect_to @product, notice: 'Product was successfully created.' }
		format.html { redirect_to account_store_products_path(store_id: params[:store_id],account_id: params[:account_id]), notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        #format.html { redirect_to @product, notice: 'Product was successfully updated.' }
  	    format.html { redirect_to account_store_products_path(store_id: params[:store_id],account_id: params[:account_id]), notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to account_store_products_path(store_id: params[:store_id],account_id: params[:account_id]), notice: 'Product was successfully updated.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price, :store_id)
    end
end
