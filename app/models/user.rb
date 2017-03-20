class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable,
         :omniauthable, :omniauth_providers => [:facebook]


  after_create :assign_default_role

  has_many :participations
  belongs_to :year

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.password = Devise.friendly_token[0,20]
    end
  end

  def assign_default_role
    self.add_role(:fuksi) if self.roles.blank?
  end
end
