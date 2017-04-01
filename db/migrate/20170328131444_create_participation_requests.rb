class CreateParticipationRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :participation_requests do |t|
      t.references :acceptor, foreign_key: true
      t.references :participant, foreign_key: true
      t.string :description
      t.references :participation, foreign_key: true
      t.boolean :accepted

      t.timestamps
    end
  end
end
