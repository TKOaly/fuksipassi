class UsersController < ApplicationController
  load_and_authorize_resource :user

  def show
    @user = User.find(params[:id])
    @note = Note.new
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