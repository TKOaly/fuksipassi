require 'rails_helper'

RSpec.describe ParticipationRequest, type: :model do
  describe "creation" do

    it "does not succeed without Participation" do
      pr = ParticipationRequest.create(participant: FactoryGirl.create(User))
      expect(ParticipationRequest.all.count).to eq(0)
      expect(pr).to_not be_valid
    end

    it "succeeds with Participation and Participant" do
      pr = ParticipationRequest.create(participant: FactoryGirl.create(User), participation: Participation.create(points: 5))
      expect(ParticipationRequest.all.count).to eq(1)
      expect(pr).to be_valid
    end

    it "does not succees without participant" do
      pr = ParticipationRequest.create(participation: Participation.create(points: 5))
      expect(ParticipationRequest.all.count).to eq(0)
      expect(pr).to_not be_valid
    end


  end

end
