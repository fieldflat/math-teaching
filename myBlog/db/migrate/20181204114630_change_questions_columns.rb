class ChangeQuestionsColumns < ActiveRecord::Migration[5.1]
  def change
    remove_columns :questions, :text, :string
    remove_columns :questions, :string, :string
  end
end
