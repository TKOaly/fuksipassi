class LanguagesController < ApplicationController
  load_and_authorize_resource :user

  def change
    language = Language.find_by_id(params[:language])
    session[:locale] = Language.find_by_id(params[:language]).code
    if current_user.language != language
      current_user.language = language
      current_user.save
    end
    redirect_to :back
  end
end