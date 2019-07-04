class AttendancesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @attendance = @user.attendances.find_by(worked_on: Date.today)
    if @attendance.started_at.nil?
      @attendance.update_attributes(started_at: current_time)
      flash[:info] = 'おはようございます'
    elsif @attendance.finished_at.nil?
      @attendance.update_attributes(finished_at: current_time)
      flash[:info] = 'おつかれさまでした'
    else
      flash[:danger] = 'トラブルがあり、登録できませんでした。'
    end
    redirect_to @user
  end
  
  def show
    @user = User.find(params[:id])
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
  
  
  def edit
    @user = User.find(params[:id])
    @users = User.all
    @instructor = User.where(instructor: true)
    @ftime = Date.parse(params[:date])
    @ltime = @ftime.end_of_month
    @dates = user_attendances_month_date
  end
  
  def atlog
    @user = User.find(params[:id])
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
    @ftime = Date.parse(params[:date])
    @ltime = @ftime.end_of_month
    @dates =  user_attendances_month_date
  end
  
  def update
    @user = User.find(params[:id])
    @instructor = User.where(instructor: true)
      if attendances_invalid?
       attendances_params.each do |id, item|
        attendance = Attendance.find(id)
        attendance.update_attributes(item)
        end
        flash[:success] = '勤怠情報を申請しました。'
        redirect_to user_path(@user, params:{first_day: params[:date]})
        return
      else
        flash[:danger] = "不正な時間入力がありました、再入力してください。"
        redirect_to edit_attendances_path(@user, params[:date])
        return
      end
  end
  
  def update_overtime
    @user = User.find(params[:id])
    if overtime_params.each do |id,item|
      ot = Attendance.find(id)
      ot.update_attributes!(item)
      flash[:success] = "残業申請しました"
      redirect_to @user
    end
    else
      render '@user'
    end
  end
  
  def update_month
    @user = User.find(params[:id])
    if month_params.each do |id,item|
      ot = Attendance.find(id)
      ot.update_attributes!(item)
      flash[:success] = "所属長申請しました"
      redirect_to @user
    end
    else
      render '@user'
    end
  end
  
  def update_receive
    @user = User.find(params[:id])
    if receive_params.nil?
      flash[:danger] = "更新対象がありません"
      redirect_to @user
      return
    else
     receive_params.each do |id,item|
     rot = Attendance.find(id)
     rot.update_attributes(item) 
     end
     flash[:info] ="申請中です。チェック漏れがないかご確認ください。"
     redirect_to @user
     return
    end
  end
  
  def receive_overtime
    @user = User.find(params[:id])
    @users = User.all 
    @attendance = Attendance.find(params[:id]) 
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
  end
  
  
  def receive_attendance
    @user = User.find(params[:id])
    @users = User.all 
    @attendance = Attendance.find(params[:id]) 
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
  end
  
  def receive_month
    @user = User.find(params[:id])
    @users = User.all 
    @attendance = Attendance.find(params[:id]) 
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
  end
    
  private
  
  def attendances_params
    params.permit(attendances: [:started_be,:finished_be,:note,:instructor_nameat])[:attendances]
  end
  
  def overtime_params
    params.permit(attendances: [:over_time,:overtime_note,:instructor_name])[:attendances]
  end
  
  def month_params
    params.permit(attendances: [:month_date,:instructor_namemo])[:attendances]
  end
  
  def receive_params
    params.permit(attendances: [:approval,:update_box,:approval_at,:update_boxat,:approval_mo,:update_boxmo])[:attendances]
  end
end