class AddMonthDateToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :month_date, :datetime
  end
end
