class CreateHiddenEvent < ActiveRecord::Migration[5.0]
  def change
    create_table :hidden_events do |t|
      t.references :user
      t.references :event

      t.timestamps
    end
  end
end
