class UsersController < ApplicationController
  load_and_authorize_resource :user

  def show
    @user = User.find(params[:id])
    @note = Note.new
  end

  def index
    authorize! :read, User.all
    @users = User.all
    @top_fuksit = @users.select { |u| u.can_receive_points? }.sort_by(&:real_points).reverse
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end
end