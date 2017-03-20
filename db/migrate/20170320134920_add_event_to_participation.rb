class AddEventToParticipation < ActiveRecord::Migration[5.0]
  def change
    add_reference :participations, :event, foreign_key: true
  end
end
