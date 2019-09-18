class NotesController < ApplicationController
  before_action :set_note, only: [:destroy]
  load_and_authorize_resource :note

  def create
    @note = Note.new(note_params)
    @note.from = current_user

    if @note.to.can_receive_points? or admin?
      respond_to do |format|
        if @note.save
          format.html { redirect_to @note.to, notice: 'Points given :D.' }
          format.json { render events_path, status: :created, location: @note }
        else
          format.html { redirect_to @note.to, notice: 'Something went wrong' }
          format.json { render json: @note.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path, alert: "Can't add note to this user"
    end
  end

  # DELETE /participations/1
  # DELETE /participations/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Note successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def dokaa
    if current_user.has_role? :fuksi
      current_user.notes << Note.create(points: -3, description: I18n.t('notes.dokaa'), to: current_user, points_hidden: false) unless current_user.dokattu?
      redirect_to current_user, alert: I18n.t('notes.plz_no')
    else
      redirect_to root_path, alert: 'User not fuksi'
    end
  end

  def like_tutor
    # if current_user.has_role? :fuksi
      @note = Note.new(note_params)
      @note.from = current_user
      @note.points_hidden = false
      if params[:commit] && params[:commit].include?('Gibe dislike')
        @note.points = -1
      else
        @note.points = 1
      end
      if @note.to.has_role? :tutor
        if @note.save
          redirect_to @note.to, notice: I18n.t('notes.comment_tutor.success')
        else
          redirect_to @note.to, alert: I18n.t('notes.comment_tutor.error')
        end
      else
        redirect_to root_path, alert: 'User not tutor'
      end
    # else
    #   redirect_to root_path, alert: 'User not fuksi'
    end
  # end

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
