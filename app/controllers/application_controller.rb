class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_user!

  protect_from_forgery with: :exception

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :first_name, :last_name, :irc_nick]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end


end
