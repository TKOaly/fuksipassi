class AddWhoCanParticipateBooleansToParticipation < ActiveRecord::Migration[5.2]
  def change
    add_column :participations, :fresher_can_participate, :boolean, null: false, default: true
    add_column :participations, :tutor_can_participate, :boolean, null: false, default: false
  end
end
