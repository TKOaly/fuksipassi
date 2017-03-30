require 'rails_helper'

RSpec.describe User, type: :model do

  describe "new user" do
    it "only role is freshman" do
      user = FactoryGirl.create :user
      expect(user.roles.count).to eq(1)
      expect(user.roles.first.name).to eq("fuksi")
    end
  end

end
