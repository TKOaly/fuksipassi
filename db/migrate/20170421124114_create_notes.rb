class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.integer :points
      t.string :description
      t.references :from
      t.references :to
      t.boolean :points_visible

      t.timestamps
    end
  end
end
