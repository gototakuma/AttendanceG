class AddApprovalAtToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :approval_at, :integer, default: 1
  end
end
