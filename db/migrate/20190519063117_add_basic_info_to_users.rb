class AddBasicInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :basic_time, :datetime, default: Time.zone.parse("2019/05/1 07:30")
    add_column :users, :work_time, :datetime, default: Time.zone.parse("2019/5/1 08:30")
  end
end
