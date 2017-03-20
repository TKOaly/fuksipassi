require 'rails_helper'

RSpec.describe "Participations", type: :request do
  describe "GET /participations" do
    it "redirects for logged out user" do
      get participations_path
      expect(response).to have_http_status(302)
    end
  end
end
