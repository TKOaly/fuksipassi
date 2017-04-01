class CreateParticipationRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :participation_requests do |t|
      t.references :acceptor
      t.references :participant
      t.string :description
      t.references :participation
      t.boolean :accepted

      t.timestamps
    end
  end
end
