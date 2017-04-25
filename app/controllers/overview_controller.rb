class OverviewController < ApplicationController

  def index
    @participations = Participation.all
    @unconfirmed_requests = ParticipationRequest.unconfirmed
  end
end