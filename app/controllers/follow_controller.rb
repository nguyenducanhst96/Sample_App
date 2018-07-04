class FollowController < ApplicationController
  before_action :find_user, only: [:following, :followers]
  def following
    @title = t ".title"
    @users = @user.following.paginate page: params[:page]
    render "users/show_follow"
  end

  def followers
    @title = t ".title"
    @users = @user.followers.paginate page: params[:page]
    render "users/show_follow"
  end
end
