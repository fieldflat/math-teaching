class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.string :title
      t.string :content
      t.string :text
      t.string :image_name
      t.string :string

      t.timestamps
    end
  end
end
