class AddApprovalToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :approval, :integer, default: 1
  end
end
