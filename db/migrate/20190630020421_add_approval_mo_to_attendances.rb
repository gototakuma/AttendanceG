class AddApprovalMoToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :approval_mo, :integer, default: 1
    add_column :attendances, :update_boxmo, :boolean
  end
end
