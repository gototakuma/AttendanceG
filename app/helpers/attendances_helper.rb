module AttendancesHelper
  def current_time
    Time.new(
        Time.now.year,
        Time.now.month,
        Time.now.day,
        Time.now.hour,
        Time.now.min,0
        )
  end
  
  def working_times(started_at, finished_at)
    format("%.2f",(((finished_at - started_at)/ 60) / 60))
  end
  
  def working_times_sum(seconds)
    format("%.2f", seconds / 60 / 60.0)
  end
  
  def ftime(date)
    !date.nil? ? Date.parse(date) : Date.current.beginning_of_month
  end

  def user_attendances_month_date
    @user.attendances.where('worked_on >= ? and worked_on <= ?', @ftime, @ltime).order('worked_on')
  end
  
  def timeerror
    if :started_at > :finished_at
    flash[:danger] = "不正入力です。"
    redirect_to edit_attendances_path(@user,params[:date]) and return
    end
  end
end
