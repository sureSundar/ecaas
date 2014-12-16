class SubdomainsController < ApplicationController
  before_action :set_subdomain, only: [:show, :edit, :update, :destroy]

  # GET /subdomains
  # GET /subdomains.json
  def index
    @subdomains = Subdomain.all
  end

  # GET /subdomains/1
  # GET /subdomains/1.json
  def show
  end

  # GET /subdomains/new
  def new
    @subdomain = Subdomain.new
  end

  # GET /subdomains/1/edit
  def edit
  end

  # POST /subdomains
  # POST /subdomains.json
  def create
    @subdomain = Subdomain.new(subdomain_params)

    respond_to do |format|
      if @subdomain.save
        format.html { redirect_to @subdomain, notice: 'Subdomain was successfully created.' }
        format.json { render action: 'show', status: :created, location: @subdomain }
      else
        format.html { render action: 'new' }
        format.json { render json: @subdomain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subdomains/1
  # PATCH/PUT /subdomains/1.json
  def update
    respond_to do |format|
      if @subdomain.update(subdomain_params)
        format.html { redirect_to @subdomain, notice: 'Subdomain was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @subdomain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subdomains/1
  # DELETE /subdomains/1.json
  def destroy
    @subdomain.destroy
    respond_to do |format|
      format.html { redirect_to subdomains_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subdomain
      @subdomain = Subdomain.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subdomain_params
      params.require(:subdomain).permit(:email)
    end
end
