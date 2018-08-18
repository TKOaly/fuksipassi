class UsersController < ApplicationController
  load_and_authorize_resource :user

  def show
    @user = User.find(params[:id])
    @note = Note.new
  end

  def index
    if tutor?
      @users = User.all
      @top_fuksit = @users.select { |u| u.can_receive_points? }.sort_by(&:real_points).reverse
    end
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end

  def toggle_tutor
    if admin?
      @user = User.find(params[:id])
      @user.toggle_tutor
      redirect_back fallback_location: root_path, notice: "#{@user.full_name} has been modified."
    end
  end

  def toggle_admin
    if admin?
      @user = User.find(params[:id])
      @user.toggle_admin
      redirect_back fallback_location: root_path, notice: "#{@user.full_name} has been modified."
    end
  end
end