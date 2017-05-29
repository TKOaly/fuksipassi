class ParticipationRequestsController < ApplicationController

  def create
    @participation_request = ParticipationRequest.new(participation_request_params)
    pp @participation_request.participation

    respond_to do |format|
      if @participation_request.save
        format.html { redirect_to :events, notice: 'Request submitted.' }
        format.json { render events_path, status: :created, location: @participation_request }
      else
        format.html { redirect_to :events, notice: 'Something went wrong' }
        format.json { render json: @participation_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept_bulk
    @participation_requests = ParticipationRequest.find(params[:p][:participation_request_ids].reject!(&:blank?))
    if @participation_requests.empty?
      flash[:notice] = "Products updated"
      redirect_to overview_path
    else
      @participation_requests.each {|p| accept(p)}
      flash[:notice] = "Products updated"
      redirect_to overview_path
    end
  end

  def accept(participation)
    if current_user.has_role? "admin"
      participation.acceptor = current_user
      participation.save
    else
      redirect_to :back, notice: 'That is not allowed. Please don\'t try that again'
    end
  end

  def participation_request_params
    params.require(:participation_request).permit(:participant_id, :participation_id, :participations)
  end
end
