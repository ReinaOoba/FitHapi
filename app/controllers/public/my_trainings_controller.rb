class Public::MyTrainingsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @my_training = MyTraining.new
  end

  def index
    @user = User.find_by(account: params[:user_account])
    @my_trainings = @user.my_trainings
  end

  def show
    @my_training = MyTraining.find(params[:id])
  end

  def create
    user = current_user
    @my_training = MyTraining.new(my_training_params)
    @my_training.user_id = user.id
    if user.my_trainings.count > 20
      redirect_to user_my_trainings_path(current_user), notice: "登録数を超えてます"
    elsif @my_training.save
      redirect_to my_training_path(@my_training), notice: '登録完了しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @my_training.update(my_training_params)
      redirect_to my_training_path(@my_training)
    else
      render :edit
    end
  end

  def destroy
    @my_training.delete
    redirect_to user_my_trainings_path(@user)
  end

private

  def my_training_params
    params.require(:my_training).permit(:menu, :set, :note, :user_id)
  end

  def ensure_correct_user
    @my_training = MyTraining.find(params[:id])
    @user = User.find_by(account: @my_training.user.account)
    unless @user == current_user
      redirect_to user_my_trainings_path(@user), notice: "他のユーザーのまいトレは編集できません"
    end
  end

end