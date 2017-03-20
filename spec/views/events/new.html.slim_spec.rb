require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      :string => "",
      :string => ""
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input#event_string[name=?]", "event[string]"

      assert_select "input#event_string[name=?]", "event[string]"
    end
  end
end
