class Admin::WeightsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = User.find_by(account: params[:user_account])
    @weights = @user.weights.order(created_at: :DESC).page(params[:page]).per(20)
  end

  def destroy
    user = User.find_by(account: params[:user_account])
    weight = Weight.find_by(id: params[:id], user_id: user.id)
    weight.destroy
    redirect_to admin_user_weights_path(user), notice: '削除完了しました'
  end

  private

  def weight_params
    params.require(:weight).permit(:number)
  end
end
