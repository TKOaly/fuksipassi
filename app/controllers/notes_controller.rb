class NotesController < ApplicationController

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


  # Never trust parameters from the scary internet, only allow the white list through.
  def note_params
    params.require(:note).permit(:to_id, :from_id, :description, :points, :point_visible)
  end
end
