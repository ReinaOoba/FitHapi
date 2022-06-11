class Public::MytrainingsController < ApplicationController
  def new
    @mytrainig = MyTraining.new
  end

  def index
    user = User.find_by([params:account])
    @mytrainings = user.MyTraining.where(params:[:user_id])
  end

  def show
    @mytrainig = MyTraining.find(params[:id])
  end

  def create
    @mytrainig = MyTraining.new(params[:id])
    if @mytrainig.save
      redirect_to mytrainig_path(@mytrainig)
    else
      render :new
    end
  end

  def edit
    @mytrainig = MyTraining.find(params[:id])
  end

  def update
    @mytrainig = MyTraining.find(params[:id])
    if @mytrainig.update
      redirect_to mytrainig_path(@mytraining)
    else
      render :edit
    end
  end

  def destroy
    mytraining = MyTraining.find(params[:id])
    mytraining.delete
    redirect_to mytrainings_path(user)
private

  def mytraining_params
    params.require(:mytrainig).permit(:menu, :set, :note).merge(user_id: current_user.id)
  end

end
