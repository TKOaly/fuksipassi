require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        :string => "",
        :string => ""
      ),
      Event.create!(
        :string => "",
        :string => ""
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
