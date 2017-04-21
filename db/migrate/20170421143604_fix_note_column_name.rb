class FixNoteColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :notes, :points_visible, :points_hidden

  end
end
