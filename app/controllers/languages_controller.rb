class LanguagesController < ApplicationController
  load_and_authorize_resource :user, only: [:set_user_language]

  def change
    language = Language.find_by_id(params[:language])
    session[:locale] = Language.find_by_id(params[:language]).code
    set_user_language(language) if current_user
    redirect_to :back
  end

  private

  def set_user_language(language)
    if current_user.language != language
      current_user.language = language
      current_user.save
    end
  end
end