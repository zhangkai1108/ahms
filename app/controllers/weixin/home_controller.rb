class Weixin::HomeController < Weixin::ApplicationController
  skip_before_filter :check_weixin_user, :only => [:show]
  skip_before_filter :check_weixin_legality, :only => [:show]
  def welcome
  end

  def show
    render :text => params[:echostr]
  end

  def  call

  end
end
