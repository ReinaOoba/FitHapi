class Admin::UsersController < ApplicationController
   before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

 def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "#{@user.account}さんの会員情報を更新しました"
       redirect_to admin_user_path(@user.id)
    else
       render :edit
    end
 end

 private
 def user_params
    params.require(:user).permit(:account, :name, :email, :introduction, :is_deleted)
 end
end
