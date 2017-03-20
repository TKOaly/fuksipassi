class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.name :string, null: false, uniqueness: true
      t.date :date
      t.url :string

      t.timestamps
    end
  end
end
