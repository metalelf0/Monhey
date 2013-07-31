class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def authorize_resource resource
    if resource.user == current_user
      yield
    else
      flash[:error] = "You are not authorized to view this resource!"
      redirect_to root_url
    end
  end


  def current_user
    if Rails.env == "test"
      @current_user ||= User.first
    else
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end

  helper_method :current_user  
end
