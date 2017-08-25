class Language < ApplicationRecord
  has_many :users

  validates :name, presence: true, uniqueness: true
  validates :en_name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
end