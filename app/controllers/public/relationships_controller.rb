class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find_by(account: params[:user_account])
    current_user.follow(user.id)
    redirect_to request.referer
  end

  def destroy
    user = User.find_by(account: params[:user_account])
    current_user.unfollow(user.id)
    redirect_to request.referer
  end

  def followings
    @user = User.find_by(account: params[:user_account])
    @users = @user.followings
  end

  def followers
    @user = User.find_by(account: params[:user_account])
    @users = @user.followers
  end

end
