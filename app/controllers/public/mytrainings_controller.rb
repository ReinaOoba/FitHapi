class Public::MytrainingsController < ApplicationController
  def index
    @mytrainings = MyTraining.where(params:[:user_id])
  end
end
