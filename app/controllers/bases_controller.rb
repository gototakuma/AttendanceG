class BasesController < ApplicationController
  before_action :admin_user, only: [:index,:new,:edit,:destroy]
  
  def new
    @base = Base.new
  end
  
  def index
    @bases = Base.all
  end
  

  def update
    @base = Base.find(params[:id])
    if @base.update_attributes(base_params)
      flash[:success] = "拠点情報を更新しました。"
      redirect_to bases_url
    else
      render @base
    end
  end

  def create
    @base = Base.new(base_params)
    if @base.save
      flash[:success] = "拠点を追加しました"
      redirect_to bases_url
    else
      flash[:danger] = "失敗"
      render bases_url
    end
  end

  def edit
    @base = Base.find(params[:id])
  end
  

  def destroy
    Base.find(params[:id]).destroy
    flash[:success] = "削除しました"
    redirect_to bases_url 
  end
  
  private
  
  def base_params
    params.require(:base).permit(:basename,:basenumber,:baseattendance)
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
end

