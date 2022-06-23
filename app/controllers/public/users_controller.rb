class Public::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :unsubscribe]
  before_action :ensure_correct_articles_user, only: [:private_articles]

  def show
    @user = User.find_by(account: params[:account])
    @profile_image =  @user.profile_image
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "更新に成功しました"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  def unsubscribe
  end

  def withdrawal
    user = current_user
    if user.account == 'guest'
      redirect_to root_path, alert: 'ゲストユーザーの変更・退会はできません。'
    else
      user.update(is_deleted: true)
      reset_session
      flash[:notice] = "退会しました"
      redirect_to root_path
    end
  end

  def post_articles
   @user = User.find_by(account: params[:user_account])
   @articles = @user.articles.where(status: 0).page(params[:page])
  end

  def private_articles
    @user = User.find_by(account: params[:user_account])
    @articles = @user.articles.where(status: 1).page(params[:page])
  end

  def favorite_articles
    @user = User.find_by(account: params[:user_account])
    @favorites = @user.favorites.includes(:article).where(article: {status: 0}).page(params[:page])
  end

private
  def user_params
    params.require(:user).permit(:name, :account, :email, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find_by(account: params[:account])
    if @user.account == 'guest'
      redirect_to root_path, alert: 'ゲストユーザーの変更・退会はできません。'
    elsif @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def ensure_correct_articles_user
    @user = User.find_by(account: params[:user_account])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
