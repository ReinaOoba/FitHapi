class Public::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :withdrawal]

  def show
    @user = User.find_by(account: params[:account])
    @profile_image =  @user.profile_image
  end

  def edit
    @user = User.find_by(account: params[:account])
  end

  def update
    @user = User.find_by(account: params[:account])
    if @user.update(user_params)
      flash[:notice] = "更新に成功しました"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end


  def withdrawal
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end

private
  def user_params
    params.require(:user).permit(:name, :account, :email, :introduction, :profile_image)
  end

  def ensure_correct_user
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
