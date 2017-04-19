require 'rails_helper'


RSpec.describe ParticipationRequest, type: :model do
  describe 'creation' do

    it 'does not succeed without Participation' do
      pr = ParticipationRequest.create(participant: FactoryGirl.create(:user))
      expect(ParticipationRequest.all.count).to eq(0)
      expect(pr).to_not be_valid
    end

    it 'succeeds with Participation and Participant' do
      pr = ParticipationRequest.create(participant: FactoryGirl.create(:user), participation: Participation.create(points: 5))
      expect(ParticipationRequest.all.count).to eq(1)
      expect(pr).to be_valid
    end

    it 'does not succees without participant' do
      pr = ParticipationRequest.create(participation: Participation.create(points: 5))
      expect(ParticipationRequest.all.count).to eq(0)
      expect(pr).to_not be_valid
    end

    it 'does not succeed twice for the same participant and event' do
      fuksi = FactoryGirl.create(:user)
      p = Participation.create(points: 5)

      ParticipationRequest.create(participant: fuksi, participation: p)
      ParticipationRequest.create(participant: fuksi, participation: p)

      expect(fuksi.participation_requests.count).to eq(1)
      expect(ParticipationRequest.all.count).to eq(1)
    end

  end

end
