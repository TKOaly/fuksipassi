class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable,
         :omniauthable, :omniauth_providers => []

  mount_uploader :image, ImageUploader

  after_create :assign_default_role
  has_many :participation_requests, :class_name => 'ParticipationRequest', foreign_key: 'participant_id', dependent: :destroy
  has_many :accepted_participations, :class_name => 'ParticipationRequest', foreign_key: 'acceptor_id', dependent: :destroy
  has_many :participations, :through => :participation_requests
  # has_many :hidden_participations, :class_name => 'Participation', foreign_key: 'hider_id'
  has_many :notes, :class_name => 'Note', foreign_key: 'to_id', dependent: :destroy
  has_many :submitted_notes, :class_name => 'Note', foreign_key: 'from_id'
  has_many :hidden_events, dependent: :destroy
  has_many :hidden, class_name: 'Event', through: :hidden_events
  belongs_to :year, required: false
  belongs_to :language, required: false

  attr_accessor :login

  # scope :freshmen, -> { where(has_role? 'fuksi') }


  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validates :privacy_policy_consent,
            :presence => true,
            inclusion: { in: [ true ] }
  validates :username,
            length: { 
                maximum: 32, minimum: 2
            },
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            }
  validates :first_name,
            presence: true
  validates :last_name,
            presence: true
  validates :irc_nick,
            length: {
                maximum: 32, minimum: 2,
                allow_nil: true,
                allow_blank: true
            },
            :uniqueness => {
                :case_sensitive => false,
                allow_nil: true,
                allow_blank: true
            }

  def full_name
    "#{first_name} #{last_name}"
  end

  def confirmed_points
    (participation_requests.confirmed.any? ?
        participation_requests.confirmed.map { |p| p.participation.points }.inject(:+) : 0) +
        (notes.visible.any? ?
            notes.visible.map { |n| n.points }.inject(:+) : 0)
  end

  def all_points
    (participations.any? ?
        participations.map { |p| p.points }.inject(:+) : 0) +
        (notes.visible.any? ?
            notes.visible.map { |n| n.points }.inject(:+) : 0)
  end

  def real_points
    (participation_requests.confirmed.any? ?
        participation_requests.confirmed.map { |p| p.participation.points }.inject(:+) : 0) +
        (notes.any? ?
            notes.map { |n| n.points }.inject(:+) : 0)
  end

  def points_given
    result = submitted_notes.map { |n| n.points }.inject(:+)
    return result ? result : 0
  end

  def dokattu?
    notes.where(from: [nil, false]).any?
  end

  def can_receive_points?
    !(self.has_role? :admin) && !(self.has_role? :tutor)
  end

  def unconfirmed_count
    participation_requests.unconfirmed.count
  end

  def toggle_tutor
    if has_role?("tutor")
      remove_role "tutor"
      add_role "fuksi"
    else
      add_role "tutor"
      remove_role "fuksi"
    end

  end

  def toggle_admin
    if has_role?("admin")
      remove_role "admin"
    else
      add_role "admin"
    end
  end


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def assign_default_role
    self.add_role(:fuksi) if self.roles.blank?
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", {:value => login.downcase}]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end

end
