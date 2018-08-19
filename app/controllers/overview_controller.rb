class OverviewController < ApplicationController
  load_and_authorize_resource :participation
  load_and_authorize_resource :participation_request

  def index
    if fuksi?
      redirect_back fallback_location: root_path, alert: "You are not authorized to access this page."
    else
      all_unconfirmed_requests = ParticipationRequest.unconfirmed
      if params[:event]
        @unconfirmed_requests = all_unconfirmed_requests.joins(:participation).where(participations: { event_id: params[:event] })
        @selected_event = Event.find_by_id params[:event]
      elsif params[:task]
        @unconfirmed_requests = all_unconfirmed_requests.where(participation_id: params[:task])
        @selected_task = Participation.find_by_id params[:task]
      elsif params[:user]
        @unconfirmed_requests = all_unconfirmed_requests.where(participant_id: params[:user])
        @selected_user = User.find_by_id params[:user]
      else
        @unconfirmed_requests = all_unconfirmed_requests
      end
      @unconfirmed_requests = @unconfirmed_requests
                                  .joins(:participation)
                                  .joins("LEFT JOIN events ON events.id = participations.event_id")
                                  .joins(:participant)
                                  .order("events.name ASC, participations.description ASC, users.last_name ASC, users.first_name ASC")
      @events = all_unconfirmed_requests.collect(&:event).compact.uniq.sort_by(&:name)
      @users = all_unconfirmed_requests.collect(&:participant).compact.uniq.sort_by {|u| [u.first_name, u.last_name]}
      @tasks = all_unconfirmed_requests.collect(&:participation).compact.uniq.select {|p| p.participation_type == 'task'}.sort_by(&:description)
    end
  end
end