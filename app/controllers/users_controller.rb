class UsersController < ApplicationController
  load_and_authorize_resource
  def show
    @user = User.find(params[:id])
    @participation_requests = @user.participation_requests

  end

  def index
    @users = User.all
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end
end