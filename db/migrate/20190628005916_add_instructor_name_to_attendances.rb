class AddInstructorNameToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :instructor_name, :integer
  end
end
