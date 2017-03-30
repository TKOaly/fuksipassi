require 'rails_helper'

RSpec.describe "Logging in and out", type: :feature do
  before :each do
    user = FactoryGirl.create(:user)
  end

  describe "logging in" do

    it "user is able to log in" do
      user = User.first

      visit login_path
      fill_in 'user_login', with: user.username
      fill_in 'user_password', with: "password123"
      click_button 'Log in'

      expect(page).to have_content('Signed in successfully')
    end

  end

  describe 'user is able to log out' do

    it 'user is able to log out' do
      login_as(User.first)
      visit events_path
      click_button 'Logout'

      expect(page).to have_content('Signed out successfully')
    end
  end
end
