class Note < ApplicationRecord
  belongs_to :from, :class_name => 'User', required: false
  belongs_to :to, :class_name => 'User'

  # validates :participation, :presence => true, uniqueness: true
  # validates :participant, :presence => true
  validates :points,
            presence: true
  validates :description,
            presence: true
  validates :to,
            presence: true,
            associated: true
  validate :freshmen_not_causing_mayhem

  scope :visible, -> { where(points_hidden: [nil, false]) }

  def freshmen_not_causing_mayhem
    if from and from.has_role? :fuksi
      unless points == 1 || points == -1
        errors.add(:points, 'Wrong amount of points')
      end
      unless to.has_role? :tutor
        errors.add(:to, 'Freshmen cannot give points to other than tutors')
      end
      if points_hidden
        errors.add(:points_hidden, 'Freshmen cannot give hidden points')
      end
    elsif !from
      unless points == -3
        errors.add(:points, 'Wrong amount of points')
      end
    end
  end

end
