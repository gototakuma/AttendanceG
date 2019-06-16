class AddFinishTimeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :finish_time, :datetime, default: Time.zone.parse("2019/05/1 17:30")
  end
end
