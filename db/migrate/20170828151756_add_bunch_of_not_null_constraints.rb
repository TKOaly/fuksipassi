class AddBunchOfNotNullConstraints < ActiveRecord::Migration[5.0]
  def change
    change_column :hidden_events, :user_id, :integer, null: false
    change_column :hidden_events, :event_id, :integer, null: false
    change_column :notes, :points, :integer, null: false
    change_column :notes, :description, :string, null: false
    Note.where(to_id: nil).each{ |n| n.destroy}
    change_column :notes, :to_id, :integer, null: false
    Note.where(points_hidden: nil).each{ |n| n.update_attributes(points_hidden: false)}
    change_column :notes, :points_hidden, :boolean, null: false, default: false
    change_column :participation_requests, :participant_id, :integer, null: false
    change_column :participation_requests, :participation_id, :integer, null: false
    ParticipationRequest.where(accepted: nil).each{ |p| p.update_attributes(accepted: false)}
    ParticipationRequest.where(accepted: nil).each{ |p| p.destroy}
    change_column :participation_requests, :accepted, :boolean, null: false, default: false
    change_column :participations, :points, :integer, null: false
    change_column :participations, :participation_type, :integer, null: false
    change_column :users, :irc_nick, :string, null: true
  end
end
