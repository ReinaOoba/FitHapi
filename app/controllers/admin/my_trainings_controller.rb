class Admin::MyTrainingsController < ApplicationController
  def index
    @user = User.find_by(account: params[:user_account])
    @my_trainings = @user.my_trainings
  end

  def show
    @my_training = MyTraining.find(params[:id])
  end

  def destroy
    my_training = MyTraining.find(params[:id])
    user = my_training.user
    my_training.delete
    redirect_to admin_user_my_trainings_path(user)
  end
end
