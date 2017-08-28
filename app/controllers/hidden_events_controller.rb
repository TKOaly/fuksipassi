class HiddenEventsController < ApplicationController
  load_and_authorize_resource :hidden_event

  def create
    if current_user
      @hidden_event = HiddenEvent.create(user_id: current_user.id, event_id: params[:event_id])

      respond_to do |format|
        if @hidden_event.save
          format.html { redirect_to events_path, notice: 'Event was successfully hidden.'}
          format.json { render :show, status: :created, location: @hidden_event }
        else
          format.html { render :new }
          format.json { render json: @hidden_event.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @hidden_event = HiddenEvent.where(user_id: current_user.id, event_id: params[:event_id]).take
    @hidden_event.destroy
    respond_to do |format|
      format.html { redirect_to events_path(show_hidden: true), notice: 'Event was successfully unhidden.' }
      format.json { head :no_content }
    end
  end
end