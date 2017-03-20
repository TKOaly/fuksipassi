require 'rails_helper'

RSpec.describe "participations/show", type: :view do
  before(:each) do
    @participation = assign(:participation, Participation.create!(
      :points => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
  end
end
