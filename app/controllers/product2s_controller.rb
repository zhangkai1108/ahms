class Product2sController < ApplicationController
  before_action :set_product2, only: [:show, :edit, :update, :destroy]

  # GET /product2s
  # GET /product2s.json
  def index
    @product2s = Product2.all
  end

  # GET /product2s/1
  # GET /product2s/1.json
  def show
  end

  # GET /product2s/new
  def new
    @product2 = Product2.new
  end

  # GET /product2s/1/edit
  def edit
  end

  # POST /product2s
  # POST /product2s.json
  def create
    @product2 = Product2.new(product2_params)

    respond_to do |format|
      if @product2.save
        format.html { redirect_to @product2, notice: 'Product2 was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product2 }
      else
        format.html { render action: 'new' }
        format.json { render json: @product2.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product2s/1
  # PATCH/PUT /product2s/1.json
  def update
    respond_to do |format|
      if @product2.update(product2_params)
        format.html { redirect_to @product2, notice: 'Product2 was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product2.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product2s/1
  # DELETE /product2s/1.json
  def destroy
    @product2.destroy
    respond_to do |format|
      format.html { redirect_to product2s_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product2
      @product2 = Product2.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product2_params
      params.require(:product2).permit(:name)
    end
end
