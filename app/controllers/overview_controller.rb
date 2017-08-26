class OverviewController < ApplicationController
  authorize_resource :class => false
  load_and_authorize_resource :participation
  load_and_authorize_resource :participation_request

  def index
    all_unconfirmed_requests = ParticipationRequest.unconfirmed
    if params[:event]
      @unconfirmed_requests = all_unconfirmed_requests.joins(:participation).where(participations: { event_id: params[:event] })
      @selected_event = Event.find_by_id params[:event]
    elsif params[:user]
      @unconfirmed_requests = all_unconfirmed_requests.where(participant_id: params[:user])
      @selected_user = User.find_by_id params[:user]
    else
      @unconfirmed_requests = all_unconfirmed_requests
    end
    @unconfirmed_requests = @unconfirmed_requests.compact.sort_by {|p| [p.event.name, p.participation, p.participant.first_name, p.participant.last_name]}
    @events = all_unconfirmed_requests.collect(&:event).compact.uniq.sort_by(&:name)
    @users = all_unconfirmed_requests.collect(&:participant).compact.uniq.sort_by {|u| [u.first_name, u.last_name]}
  end
end