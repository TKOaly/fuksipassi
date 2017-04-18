class OverviewController < ApplicationController

  def index
    @participations = Participation.all
    @unconfirmed_requests = ParticipationRequest.unconfirmed.map { |p| p.participation }.uniq.map { |event| event.participation_requests.unconfirmed }
  end
end