    class Event < ApplicationRecord
      has_many :participations
      belongs_to :year

      # accepts_nested_attributes_for :participations
      attr_accessor :points


      def points_for_participation
        if self.participations.first
          self.participations.first.points
        else
          0
        end
      end


    end
