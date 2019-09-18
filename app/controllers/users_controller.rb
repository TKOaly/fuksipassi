class UsersController < ApplicationController
  load_and_authorize_resource :user

  def show
    @user = User.find(params[:id])
    if @user.has_role?(:fuksi) && fuksi? && @user != current_user
      redirect_back fallback_location: root_path, alert: "You are not authorized to access this page."
    end
    @note = Note.new
  end

  def index
    if tutor? || admin?
      @users = User.all
      @top_fuksit = @users.select { |u| u.can_receive_points? }.sort_by(&:real_points).reverse
      @top_tutors = @users.tutors.sort_by(&:real_points).reverse
    end
    if fuksi?
      @users = User.all
      @top_tutors = @users.tutors.sort_by(&:real_points).reverse
    end
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end

  def destroy
    if admin?
      @user = User.find(params[:id])
      @user.destroy
      redirect_to users_path, notice: "User destroyed."
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

  private

  def sort_users(users)
    return users.sort do |a, b|
      [b.real_points, a.full_name.downcase] <=> [a.real_points, b.full_name.downcase]
    end
  end
end