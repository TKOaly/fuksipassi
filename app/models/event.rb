    class Event < ApplicationRecord
      has_many :participations, dependent: :destroy
      belongs_to :year

      # accepts_nested_attributes_for :participations
      attr_accessor :points

      scope :future, -> {where("date > ?", Time.zone.now)}
      scope :past, -> {where("date < ?", Time.zone.now)}


      def points
        if self.participations
          participations.map { |p| p.points }.inject(:+)
        else
          0
        end
      end

      def future?
        # date > Date.today
      end


    end
