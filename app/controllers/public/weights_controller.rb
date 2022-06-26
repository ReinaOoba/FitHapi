class Public::WeightsController < ApplicationController
  before_action :ensure_correct_user

  def index
    @new_weight = Weight.new
    @chart_weights = Weight.where(user_id: @user.id).order(created_at: :DESC).limit(7).group_by_day(:created_at, format: "%Y/%m/%d").sum(:number)
    @weights = @user.weights.order(created_at: :DESC).limit(7)
    @url = user_weights_path
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

  def edit
    @weight = Weight.find(params[:id])
    @url = user_weight_path
  end

  def update
    @weight = Weight.find(params[:id])
    if @weight.update(weight_params)
      redirect_to user_weights_path(@user)
    else
      render :edit
    end
  end

  private

  def weight_params
    params.require(:weight).permit(:number).merge(user_id: current_user.id)
  end

  def ensure_correct_user
    @user = User.find_by(account: params[:user_account])
    unless @user == current_user
      redirect_to user_path(@user),notice: "他ユーザーの体重の閲覧・編集はできません"
    end
  end

end
