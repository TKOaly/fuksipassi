class AddDescriptionStringToParticipations < ActiveRecord::Migration[5.0]
  def change
    add_column :participations, :description, :string
  end
end
