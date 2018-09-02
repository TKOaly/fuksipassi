class CreateHiddenParticipation < ActiveRecord::Migration[5.2]
  def change
    create_table :hidden_participations do |t|
      t.references :user
      t.references :participation
    end
  end
end
