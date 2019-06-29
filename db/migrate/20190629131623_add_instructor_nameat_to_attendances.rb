class AddInstructorNameatToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :instructor_nameat, :integer
  end
end
