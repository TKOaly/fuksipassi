class OverviewController < ApplicationController

  def index
    @participations = Participation.all
    @unconfirmed = ParticipationRequest.unconfirmed
  end
end