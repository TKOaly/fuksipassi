class AddYearToEvents < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :year, foreign_key: true
  end
end
