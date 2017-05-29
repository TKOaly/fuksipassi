class OverviewController < ApplicationController
  authorize_resource :class => false
  load_and_authorize_resource :participation
  load_and_authorize_resource :participation_request

  def index
    @participations = Participation.all
    @unconfirmed_requests = ParticipationRequest.unconfirmed
  end
end