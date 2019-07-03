class CreateBases < ActiveRecord::Migration[5.1]
  def change
    create_table :bases do |t|
      t.string :basename
      t.integer :basenumber
      t.string :baseattendance

      t.timestamps
    end
  end
end
