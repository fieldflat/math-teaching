class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def is_loginned?
    if !@current_user
      flash[:notice] = "ログインをしてください"
      redirect_to("/")
    end
  end

end
