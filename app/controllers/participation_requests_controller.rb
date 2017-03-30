class ParticipationRequestsController < ApplicationController

  def create
    # TODO: do not allow multiple requests for same point
    @participation_request = ParticipationRequest.new(participation_request_params)


    respond_to do |format|
      if @participation_request.save
        format.html { redirect_to :back, notice: 'Request submitted.' }
        format.json { render :show, status: :created, location: @participation_request }
      else
        format.html { render :new }
        format.json { render json: @participation_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def participation_request_params
    params.require(:participation_request).permit(:participant_id, :participation_id)
  end
end
