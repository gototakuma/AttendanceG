class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:show,:edit,:update,:destroy]
  before_action :correct_user, only: [:edit,:update]
  before_action :admin_user, only: [:destroy,:edit_basic_info,:update_basic_info]
  
  def show
    @user = User.find(params[:id])
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "削除しました"
    redirect_to users_url 
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザの新規作成に成功しました。"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def edit_basic_info
    @user = User.find(params[:id])
  end
  
  def update_basic_info
    @user = User.find(params[:id])
    if @user.update_attributes(basic_info_params)
        flash[:success] = "基本情報を更新しました。"
        redirect_to @user
    else
      render 'edit_basic_info'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:belongs)
  end
  
  def basic_info_params
    params.require(:user).permit(:basic_time,:work_time)
  end
  
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] ="ログインしてください"
      redirect_to login_url
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
