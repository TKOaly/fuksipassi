class Note < ApplicationRecord
  belongs_to :from, :class_name => 'User'
  belongs_to :to, :class_name => 'User'

  # validates :participation, :presence => true, uniqueness: true
  # validates :participant, :presence => true

end
