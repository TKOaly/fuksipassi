class NotesController < ApplicationController
  before_action :set_note, only: [:destroy]

  def create
    @note = Note.new(note_params)
    @note.from = current_user

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note.to, notice: 'Points given :D.' }
        format.json { render events_path, status: :created, location: @note }
      else
        format.html { redirect_to @note.to, notice: 'Something went wrong' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participations/1
  # DELETE /participations/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Note successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def dokaa
    @note = Note.new(points: -3, description: 'dokasit fuksipassin', to: current_user)
    @note.save unless current_user.dokattu?

    redirect_to @note.to, notice: 'älä plz'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def note_params
    params.require(:note).permit(:to_id, :from_id, :description, :points, :points_hidden)
  end
end
