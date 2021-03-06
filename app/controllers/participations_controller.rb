class ParticipationsController < ApplicationController
  before_action :set_participation, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :participation

  # GET /participations/1
  # GET /participations/1.json
  def show
    if @participation.event
      redirect_to @participation.event

    end
    @unattended_participations = [@participation]-current_user.participations
    @participation_request = ParticipationRequest.new

  end

  # GET /participations/new
  def new
    @participation = Participation.new
  end

  # GET /participations/1/edit
  def edit
  end

  # POST /participations
  # POST /participations.json
  def create
    @participation = Participation.new(participation_params)
    # @participation.participation_type = 2

    respond_to do |format|
      if @participation.save
        format.html { redirect_to @participation, notice: 'Participation was successfully created.' }
        format.json { render :show, status: :created, location: @participation }
      else
        format.html { render :new }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participations/1
  # PATCH/PUT /participations/1.json
  def update
    respond_to do |format|
      if @participation.update(participation_params)
        format.html { redirect_to @participation, notice: 'Participation was successfully updated.' }
        format.json { render :show, status: :ok, location: @participation }
      else
        format.html { render :edit }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participations/1
  # DELETE /participations/1.json
  def destroy
    if @participation.participation_type != 0
      @participation.destroy
      respond_to do |format|
        format.html { redirect_to events_url, notice: 'Participation was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_participation
    @participation = Participation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def participation_params
    params.require(:participation).permit(:points, :description, :event_id, :participation_type, :fresher_can_participate, :tutor_can_participate)
  end
end
