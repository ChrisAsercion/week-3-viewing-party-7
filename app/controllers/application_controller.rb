class ApplicationController < ActionController::Base

  before_action :require_login

  helper_method :current_user

  def current_user
    
    current_user ||= User.find(session[:user_id]) if session[:user_id]
   
  end

  private
    unless current_user
      flash[:alert] = 'You must be logged in or registered to access your dashboard'
    end


  
end
