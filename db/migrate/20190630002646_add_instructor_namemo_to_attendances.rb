class AddInstructorNamemoToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :instructor_namemo, :integer
  end
end
