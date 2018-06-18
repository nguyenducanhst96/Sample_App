class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, :check_expiration,
    only: [:edit, :update]
  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".flash_info_reset"
      redirect_to root_url
    else
      flash.now[:danger] = t ".flash_danger"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t(".error_password_empty")
      render :edit
    elsif @user.update_attributes user_params
      log_in @user
      flash[:success] = t ".flash_success_reset"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def get_user
    @user = User.find_by email: params[:email]
  end

  def valid_user
    redirect_to root_url unless @user &. activated? &&
                                @user.authenticated?(:reset, params[:id])
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t "password_resets.check_expiration.flash_danger_expired"
    redirect_to new_password_reset_url
  end
end