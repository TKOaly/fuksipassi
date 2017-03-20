class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable


  after_create :assign_default_role

  has_many :participations
  belongs_to :year


  def assign_default_role
    self.add_role(:fuksi) if self.roles.blank?
  end
end
