class AddUpdateBoxatToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :update_boxat, :boolean
  end
end
