require 'rails_helper'

RSpec.describe "participations/index", type: :view do
  before(:each) do
    assign(:participations, [
      Participation.create!(
        :points => 2
      ),
      Participation.create!(
        :points => 2
      )
    ])
  end

  it "renders a list of participations" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
