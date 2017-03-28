class CreateParticipationRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :participation_requests do |t|
      t.references :acceptor_id, foreign_key: true
      t.references :participant_id, foreign_key: true
      t.string :description
      t.references :participation_id, foreign_key: true
      t.boolean :accepted

      t.timestamps
    end
  end
end
