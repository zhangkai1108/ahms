class WeixinController < ApplicationController
  def check
    render :text => params[:echostr]
  end
end
