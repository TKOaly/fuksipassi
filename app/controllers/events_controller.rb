require 'net/http'
require 'uri'

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :event

  # GET /events
  # GET /events.json
  def index
    @show_hidden = params[:show_hidden]

    if tutor?
      if params[:show_hidden]
        @unattended_events = (Event.past - Participation.event.for_freshers_strictly.collect(&:event)) + Participation.tasks.for_tutors - current_user.participations.events_and_tasks.map { |u| u.event ? u.event : u }
      else
        @unattended_events = (Event.past.unhidden(current_user.id) - Participation.event.for_freshers_strictly.collect(&:event)) + Participation.tasks.for_tutors.unhidden(current_user.id) - current_user.participations.events_and_tasks.map { |u| u.event ? u.event : u }
      end
    else
      if params[:show_hidden]
        @unattended_events = (Event.past - Participation.event.for_tutors_strictly.collect(&:event)) + Participation.tasks.for_tutors - current_user.participations.events_and_tasks.map { |u| u.event ? u.event : u }
      else
        @unattended_events = (Event.past.unhidden(current_user.id) - Participation.event.for_tutors_strictly.collect(&:event)) + Participation.tasks.for_tutors.unhidden(current_user.id) - current_user.participations.events_and_tasks.map { |u| u.event ? u.event : u }
      end
    end
    @all_participations = Participation.events_and_tasks.map { |u| u.event ? u.event : u }.sort_by{|e| e.name.downcase}
    @participated_events = current_user.participations.events_and_tasks.map { |u| u.event ? u.event : u }
    @hidden_event_ids = HiddenEvent.where(user_id: current_user.id).collect(&:event_id)
    @hidden_participation_ids = HiddenParticipation.where(user_id: current_user.id).collect(&:participation_id)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @participation_request = ParticipationRequest.new
    @participation = Participation.new
    if tutor?
      @unattended_participations = @event.participations.for_tutors.extras - current_user.participations.for_tutors.extras
    else
      @unattended_participations = @event.participations.for_freshers.extras - current_user.participations.for_freshers.extras
    end
    @main_participation = @event.participations.events - current_user.participations.events
  end

  # GET /events/new
  def new
    tekis_events = fetch_tekis_events
    if request.query_parameters.has_key?(:tekisEventId)
      event_id = request.query_parameters['tekisEventId']
      @selected_event = tekis_events.select {|event| event['id'] == Integer(event_id)}[0]
    end
    @tekis_events = tekis_events
    @event = Event.new
    @participation = Participation.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        participation = Participation.new(event: @event, points: params[:event][:event_points], participation_type: 0, fresher_can_participate: params[:event][:fresher_can_participate], tutor_can_participate: params[:event][:tutor_can_participate])
        if participation.save
          format.html { redirect_to @event, notice: 'Event was successfully created.' }
          format.json { render :show, status: :created, location: @event }
        else
          @event.destroy
          format.html { render :new }
          format.json { render json: participation.errors, status: :unprocessable_entity }
        end
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
    p.points = params[:event][:event_points] if params[:event][:event_points] && p
    p.fresher_can_participate = params[:event][:fresher_can_participate] if params[:event][:fresher_can_participate] && p
    p.tutor_can_participate = params[:event][:tutor_can_participate] if params[:event][:tutor_can_participate] && p
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
    params.require(:event).permit(:name, :date, :event_link)
  end

  # Fetch events from TKO-aly api
  def fetch_tekis_events
    auth_key = ENV['TKO_ALY_EVENT_API']
    from_date = Time.now.strftime('%Y-%m-') + '01'
    url = URI.parse('https://members.tko-aly.fi/api/events?fromDate=' + from_date)
    request = Net::HTTP::Get.new(url)
    request.add_field('X-Token', auth_key)

    response = Net::HTTP.start(url.host, url.port, :use_ssl => true) do |http|
      http.request(request)
    end
    JSON.parse(response.body) 
  end
end
