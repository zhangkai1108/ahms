class ApisController < ApplicationController
  layout  'sample'
  # GET /apis
  # GET /apis.json
  def index
    @api = Api.new
    @apis = Api.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @apis }
    end
  end

  # GET /apis/1
  # GET /apis/1.json
  def show
    @api = Api.find(params[:id])
    @apis = Api.all
    render(:template => 'apis/index')
  end

  # GET /apis/new
  # GET /apis/new.json
  def new
    @api = Api.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @api }
    end
  end

  # GET /apis/1/edit
  def edit
    @api = Api.find(params[:id])
  end

  # POST /apis
  # POST /apis.json
  def create
    @api = Api.new(params[:api])
    @api.save
    file_join = getDisplayFile()
    file = File.new(file_join,'w')
    file.puts(@api.cleintContent)
    file.close
    respond_to do |format|
      if @api.update_attributes(params[:api])
        format.html
        format.js
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @api.errors, status: :unprocessable_entity }
      end
    end
    end

  # PUT /apis/1
  # PUT /apis/1.json
  def update
    @api = Api.find(params[:id])
    @flag = @api.update_attributes(params[:api])
    file_join = getDisplayFile()
    file = File.new(file_join,'w')
    file.puts(@api.cleintContent)
    file.close
    respond_to do |format|
      if @flag
        format.js
      else
        format.html { render action: "apis/index" }
      end
    end
  end

  # DELETE /apis/1
  # DELETE /apis/1.json
  def destroy
    @api = Api.find(params[:id])
    @api.destroy

    respond_to do |format|
      format.html { redirect_to apis_url }
      format.json { head :no_content }
    end
   end

  def getDisplayFile
    file_join = __FILE__[0, __FILE__.index("app")]<<"app/views/apis/_display.html.erb"
  end
end
