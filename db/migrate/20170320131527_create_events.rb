class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name, null:false, uniqueness: true
      t.date :date
      t.string :url

      t.timestamps
    end
  end
end
