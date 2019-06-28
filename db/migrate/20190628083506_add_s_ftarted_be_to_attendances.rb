class AddSFtartedBeToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :started_be, :datetime
    add_column :attendances, :finished_be, :datetime
  end
end
