class CreateYears < ActiveRecord::Migration[5.0]
  def change
    create_table :years do |t|
      t.integer :year, uniqueness: true, null: false

      t.timestamps
    end
  end
end
