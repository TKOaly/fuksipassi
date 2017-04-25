class RenameEventUrlToEventurl < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :url, :event_link

  end
end
