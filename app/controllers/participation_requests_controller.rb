class ParticipationRequestsController < ApplicationController

  def create
    # TODO: do not allow multiple requests for same point
    @participation_request = ParticipationRequest.new(participation_request_params)
    pp @participation_request.participation
    if @participation_request.participant.participations.include? @participation_request.participation
      return
    end

    respond_to do |format|
      if @participation_request.save
        format.html { redirect_to :events, notice: 'Request submitted.' }
        format.json { render events_path, status: :created, location: @participation_request }
      else
        format.html { render event_path }
        format.json { render json: @participation_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def participation_request_params
    params.require(:participation_request).permit(:participant_id, :participation_id)
  end
end
