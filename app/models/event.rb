class Event < ApplicationRecord
  has_many :participations, dependent: :destroy
  has_many :participation_requests, through: :participations
  has_many :hidden_events, dependent: :destroy
  has_many :hiders, class_name: 'User', through: :hidden_events
  belongs_to :year

  # accepts_nested_attributes_for :participations
  attr_accessor :points

  scope :future, -> { where("date > ?", Time.zone.now) }
  scope :past, -> { where("date <= ? ", Time.zone.today) }
  scope :unhidden, ->(user_id) { where('id NOT IN (?)', HiddenEvent.where(user_id: user_id).collect(&:event_id) << -1) }

  validates :name,
            presence: true,
            :uniqueness => {
                :case_sensitive => false}

  def unconfirmed_count
    participation_requests.unconfirmed.count
  end

  def points
    if self.participations
      participations.map { |p| p.points }.inject(:+)
    else
      0
    end
  end

  def future?
    date >= Time.zone.now
  end




end
