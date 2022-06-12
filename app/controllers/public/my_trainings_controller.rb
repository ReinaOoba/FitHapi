class Public::MyTrainingsController < ApplicationController
  # before_action :ensure_correct_user, only: [:new, :create, :edit, :update, :destroy]

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
    @my_training = MyTraining.new(my_training_params)
    @my_training.user_id = current_user.id
    if @my_training.save
      redirect_to my_training_path(@my_training), notice: '登録完了しました'
    else
      render :new
    end
  end

  def edit
    @my_training = MyTraining.find(params[:id])
  end

  def update
    @my_training = MyTraining.find(params[:id])
    if @my_training.update(my_training_params)
      redirect_to my_training_path(@my_training)
    else
      render :edit
    end
  end

  def destroy
    my_training = MyTraining.find(params[:id])
    user = my_training.user
    my_training.delete
    redirect_to user_my_trainings_path(user)
  end

private

  def my_training_params
    params.require(:my_training).permit(:menu, :set, :note, :user_id)
  end

  def ensure_correct_user
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end