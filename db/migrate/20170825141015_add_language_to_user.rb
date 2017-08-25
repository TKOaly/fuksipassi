class AddLanguageToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :language, foreign_key: true
  end
end
