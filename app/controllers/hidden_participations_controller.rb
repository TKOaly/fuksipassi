class HiddenParticipationsController < ApplicationController
  load_and_authorize_resource :hidden_participation

  def create
    if current_user
      @hidden_participation = HiddenParticipation.create(user_id: current_user.id, participation_id: params[:participation_id])

      respond_to do |format|
        if @hidden_participation.save
          format.html { redirect_to events_path, notice: 'Challenge was successfully hidden.'}
          format.json { render :show, status: :created, location: @hidden_participation }
        else
          format.html { render :new }
          format.json { render json: @hidden_participation.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @hidden_participation = HiddenParticipation.where(user_id: current_user.id, participation_id: params[:participation_id]).take
    @hidden_participation.destroy
    respond_to do |format|
      format.html { redirect_to events_path(show_hidden: true), notice: 'Challenge was successfully unhidden.' }
      format.json { head :no_content }
    end
  end
end