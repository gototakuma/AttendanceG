class AddBoxToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :box, :boolean
  end
end
