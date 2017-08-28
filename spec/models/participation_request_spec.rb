require 'rails_helper'


RSpec.describe ParticipationRequest, type: :model do
  describe 'creation' do

    it 'does not succeed without Participation' do
      pr = ParticipationRequest.create(participant: create(:user))
      expect(ParticipationRequest.all.count).to eq(0)
      expect(pr).to_not be_valid
    end

    it 'succeeds with Participation and Participant' do
      pr = ParticipationRequest.create(participant: create(:user), participation: create(:participation))
      expect(ParticipationRequest.all.count).to eq(1)
      expect(pr).to be_valid
    end

    it 'does not succees without participant' do
      pr = ParticipationRequest.create(participation: create(:participation))
      expect(ParticipationRequest.all.count).to eq(0)
      expect(pr).to_not be_valid
    end

    it 'does not succeed twice for the same participant and event' do
      fuksi = create(:user)
      p = Participation.create(points: 5, participation_type: 1)

      ParticipationRequest.create(participant: fuksi, participation: p)
      ParticipationRequest.create(participant: fuksi, participation: p)

      expect(fuksi.participation_requests.count).to eq(1)
      expect(ParticipationRequest.all.count).to eq(1)
    end

    it 'does not succeed before event happens' do
      event = create(:event, date: Date.tomorrow)
      event.participations << create(:participation)
      pr = ParticipationRequest.create(participation: event.participations.first, participant: create(:user))

      expect(ParticipationRequest.all.count).to eq(0)
      expect(pr).to_not be_valid

    end

  end

end
