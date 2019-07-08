class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:show,:edit,:update,:destroy]
  before_action :admin_user, only: [:destroy,:edit_basic_info,:update_basic_info,:attendances_now,:index]
  before_action :correct_user, only: [:show,:edit,:update]
  before_action :admin_user_show, only: [:show]
  
  def show
    @user = User.find(params[:id])
    @users = User.all
    @count_overtime = Attendance.where(instructor_name: current_user.id).where.not(over_time: nil).where(approval: "申請中").count 
    @count_attendance = Attendance.where(instructor_nameat: current_user.id).where.not(started_be: nil).where(approval_at: "申請中").count 
    @count_month = Attendance.where(instructor_namemo: current_user.id).where(approval_mo: "申請中").count 
    @instructor = User.where(instructor: true)
    if params[:ftime].nil?
      @ftime = Date.today.beginning_of_month
    else
      @ftime = Date.parse(params[:ftime])
    end
    @ltime = @ftime.end_of_month
    (@ftime..@ltime).each do |day|
      unless @user.attendances.any?{|attendance| attendance.worked_on == day}
        record = @user.attendances.build(worked_on: day)
        record.save
      end
    end
    @dates = user_attendances_month_date
    @worked_sum = @dates.where.not(started_at: nil).count
  end
  
    
  
  def index
    @users = User.all
  end
  
  def import
    User.import(params[:file])
    redirect_to root_url
    return
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
  
  def attendances_now
    @users = User.all
  end
  
  
  
  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:belongs,:code,:basic_time,:work_time,:finish_time,:card_id)
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
   
    @user = User.find_by(id: params[:id]) 
    unless current_user?(@user) || current_user.admin?
      flash[:danger] = "他人のデータは観覧できません"
      redirect_to(root_url) 
    end
  end
  
  def instructor_user
    redirect_to(root_url) unless current_user.instructor?
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
  def admin_user_show
    redirect_to users_url if current_user.admin?
  end
end