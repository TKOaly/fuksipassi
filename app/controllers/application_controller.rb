class ApplicationController < ActionController::Base
  load_and_authorize_resource
  check_authorization :unless => :devise_controller?

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_user!

  protect_from_forgery with: :exception

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :first_name, :last_name, :irc_nick]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, alert: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end
end
