class Product1sController < ApplicationController
  before_action :set_product1, only: [:show, :edit, :update, :destroy]

  # GET /product1s
  # GET /product1s.json
  def index
    @product1s = Product1.all
  end

  # GET /product1s/1
  # GET /product1s/1.json
  def show
  end

  def new
    @product1 = Product1.new
  end

  # GET /product1s/1/edit
  def edit
  end

  # POST /product1s
  # POST /product1s.json
  def create
    @product1 = Product1.new(product1_params)

    respond_to do |format|
      if @product1.save
        format.html { redirect_to @product1, notice: 'Product1 was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product1 }
      else
        format.html { render action: 'new' }
        format.json { render json: @product1.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product1s/1
  # PATCH/PUT /product1s/1.json
  def update
    respond_to do |format|
      if @product1.update(product1_params)
        format.html { redirect_to @product1, notice: 'Product1 was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product1.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product1s/1
  # DELETE /product1s/1.json
  def destroy
    @product1.destroy
    respond_to do |format|
      format.html { redirect_to product1s_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product1
      @product1 = Product1.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product1_params
      params.require(:product1).permit(:name)
    end
end
