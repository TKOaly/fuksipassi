class ParticipationRequestsController < ApplicationController
  before_action :set_participation_request, only: [:destroy]
  load_and_authorize_resource :participation_request

  def create
    @participation_request = ParticipationRequest.new(participation_request_params)
    pp @participation_request.participation

    if @participation_request.participant.can_receive_points?
      respond_to do |format|
        if @participation_request.save
          format.html { redirect_to :events, notice: 'Request submitted.' }
          format.json { render events_path, status: :created, location: @participation_request }
        else
          format.html { redirect_to :events, alert: 'Something went wrong' }
          format.json { render json: @participation_request.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path, alert: "Can't add participation to this user"
    end
  end

  def destroy
    @participation_request.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Participation request successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def accept_bulk
    @participation_requests = ParticipationRequest.find(params[:p][:participation_request_ids].reject!(&:blank?))
    if @participation_requests.empty?
      flash[:notice] = "Participation requests accepted"
      redirect_to overview_path
    else
      @participation_requests.each {|p| accept(p)}
      flash[:notice] = "Participation requests accepted"
      redirect_to overview_path
    end
  end

  def accept(participation)
    if tutor?
      participation.acceptor = current_user
      participation.save
    else
      redirect_back fallback_location: root_path, alert: 'That is not allowed. Please don\'t try that again'
    end
  end

  private
  def set_participation_request
    @participation_request = ParticipationRequest.find(params[:id])
  end

  def participation_request_params
    params.require(:participation_request).permit(:participant_id, :participation_id, :participations)
  end
end
