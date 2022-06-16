class Admin::RelationshipsController < ApplicationController
   def followings
    @user = User.find_by(account: params[:user_account])
    @users = @user.followings
  end

  def followers
    @user = User.find_by(account: params[:user_account])
    @users = @user.followers
  end
end
