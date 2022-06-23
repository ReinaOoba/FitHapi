class Public::WeightsController < ApplicationController
  before_action :ensure_correct_user

  def index
    @new_weight = Weight.new
    @weights = @user.weights
  end

  def create
    @new_weight = Weight.new(weight_params)
    if @new_weight.save
      redirect_to user_weights_path(@user)
    else
      @weights = @user.weights
      render :index
    end
  end

  def destroy
    weight = Weight.find([params:id])
    weight.delete
    redirect_to user_weights_path(@user)
  end

  private

  def weight_params
    params.require(:weight).permit(:number).merge(user_id: current_user.id)
  end

  def ensure_correct_user
    @user = User.find_by(account: params[:user_account])
    unless @user == current_user
      redirect_to user_path(current_user), alart: '他ユーザーの体重記録の閲覧・編集はできません'
    end
  end
end
