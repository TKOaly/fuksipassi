class OverviewController < ApplicationController
  authorize_resource :class => false

  def index
    @participations = Participation.all
    @unconfirmed_requests = ParticipationRequest.unconfirmed
  end
end