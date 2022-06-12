class Admin::UsersController < ApplicationController
   before_action :authenticate_admin!

  def show
    @user = User.find_by(account: params[:account])
  end

  def index
    @users = User.page(params[:page]).per(10)
  end

  def edit
    @user = User.find_by(account: params[:account])
  end

 def update
    @user = User.find_by(account: params[:account])
    if @user.update(user_params)
      flash[:notice] = "#{@user.account}さんの会員情報を更新しました"
       redirect_to admin_user_path(@user.id)
    else
       render :edit
    end
 end

 def articles
   @user = User.find_by(account: params[:user_account])
   @articles = @user.articles.all.page(params[:page]).per(10)
 end

 private

 def user_params
    params.require(:user).permit(:account, :name, :email, :introduction, :is_deleted)
 end

end
