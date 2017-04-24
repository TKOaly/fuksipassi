require 'rails_helper'

RSpec.describe 'Events view', type: :feature do
  describe 'creating an event' do
    before :each do
      user = FactoryGirl.create(:user)
      user.add_role 'admin'
      login_as(user)
      visit new_event_path
      fill_in 'event_name', with: 'test event'
      fill_in 'event_points', with: 10

      click_button 'Create Event', match: :first
    end

    it 'is created and displays info correctly' do
      event = Event.first

      expect(page).to have_content(event.name)
      expect(page).to have_content("Possible points for participation: #{event.participations.first.points}")
    end

    it 'adds points to event' do
      event = Event.first
      expect(event).to be_valid
      expect(event.participations.first.points).to eq(10)
    end

    it 'shows as unattended when created' do
      event = Event.first
      visit events_path
      expect(find('#unattended')).to have_content('test event')
    end
  end
end
