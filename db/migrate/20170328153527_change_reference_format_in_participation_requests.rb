class ChangeReferenceFormatInParticipationRequests < ActiveRecord::Migration[5.0]
  def self.up
    rename_column :participation_requests, :participant_id_id, :participant_id
    rename_column :participation_requests, :participation_id_id, :participation_id
    rename_column :participation_requests, :acceptor_id_id, :acceptor_id

  end
end
