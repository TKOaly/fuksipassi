class HiddenEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user,
            presence: true,
            associated: true
  validates :event,
            presence: true,
            associated: true
end