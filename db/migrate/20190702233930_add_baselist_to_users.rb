class AddBaselistToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :basenumber, :integer
    add_column :users, :basename, :string
    add_column :users, :baseattendance, :string
  end
end
