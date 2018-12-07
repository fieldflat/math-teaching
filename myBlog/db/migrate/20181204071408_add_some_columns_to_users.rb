class AddSomeColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :image_name, :string
    add_column :users, :year, :integer
    add_column :users, :month, :integer
    add_column :users, :day, :integer
    add_column :users, :prefectures, :string
    add_column :users, :enthusiasm, :text
  end
end
