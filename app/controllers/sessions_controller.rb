class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user &. authenticate params[:session][:password]
      if user.activated?
        login_user user
      else
        flash[:warning] = t ".flash_warning"
        redirect_to root_url
      end
    else
      flash.now[:danger] = t ".content_danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
