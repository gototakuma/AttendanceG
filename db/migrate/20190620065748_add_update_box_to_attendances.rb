class AddUpdateBoxToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :update_box, :boolean
  end
end
