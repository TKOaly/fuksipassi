class OverviewController < ApplicationController

  def index
    @participations = Participation.all
    @unconfirmed_requests = ParticipationRequest.participations_with_unconfirmed
  end
end