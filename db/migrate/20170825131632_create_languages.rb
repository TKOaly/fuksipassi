class CreateLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :languages do |t|
      t.string :name, null: false, uniqueness: true
      t.string :en_name, null: false, uniqueness: true
      t.string :code, null: false, uniqueness: true

      t.timestamps
    end
  end
end
