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
  
  def overtimes_sub(over_time, finish_time)
    format("%.2f",(((over_time - finish_time)/ 60) / 60))
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
  
  def instructor_name_nil?
    attendances = true
    attendances_params.each do |id,item|
      if item[:started_be].present? && item[:finished_be].present? && item[:instructor_nameat].blank?
        attendances = false
      end
    end
    return attendances
  end
end  
