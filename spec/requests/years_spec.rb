require 'rails_helper'

RSpec.describe "Years", type: :request do
  describe "GET /years" do
    it "redirects for logged out user" do
      get years_path
      expect(response).to have_http_status(302)
    end
  end
end
