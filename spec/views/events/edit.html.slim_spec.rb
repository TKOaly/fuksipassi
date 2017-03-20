require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :string => "",
      :string => ""
    ))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input#event_string[name=?]", "event[string]"

      assert_select "input#event_string[name=?]", "event[string]"
    end
  end
end
