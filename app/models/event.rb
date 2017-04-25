    class Event < ApplicationRecord
      has_many :participations
      belongs_to :year

      # accepts_nested_attributes_for :participations
      attr_accessor :points

      scope :future, -> {where("date > ?", Time.zone.now)}
      scope :past, -> {where("date < ?", Time.zone.now)}


      def points
        if self.participations.first
          self.participations.first.points
        else
          0
        end
      end

      def future?
        # date > Date.today
      end


    end
