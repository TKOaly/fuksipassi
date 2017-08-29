class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :event

  # GET /events
  # GET /events.json
  def index
    @show_hidden = params[:show_hidden]
    if params[:show_hidden]
      @unattended_events = Event.past + Participation.tasks - current_user.participations.events_and_tasks.map { |u| u.event ? u.event : u }
    else
      @unattended_events = Event.past.unhidden(current_user.id) + Participation.tasks - current_user.participations.events_and_tasks.map { |u| u.event ? u.event : u }
    end
    @all_participations = Participation.events_and_tasks.map { |u| u.event ? u.event : u }
    @participated_events = current_user.participations.events_and_tasks.map { |u| u.event ? u.event : u }
    @hidden_event_ids = HiddenEvent.where(user_id: current_user.id).collect(&:event_id)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @participation_request = ParticipationRequest.new
    @participation = Participation.new
    @unattended_participations = @event.participations.extras - current_user.participations.extras
    @main_participation = @event.participations.events - current_user.participations.events
  end

  # GET /events/new
  def new
    @event = Event.new
    @participation = Participation.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.create(event_params)
    @event.participations << Participation.create(points: params[:event][:points], participation_type: 0)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    p = @event.participations.where(participation_type: 0).take
    p.points = params[:event][:points] if params[:event][:points] && p
    p.save if p
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name, :date, :event_link, :points)
  end
end
