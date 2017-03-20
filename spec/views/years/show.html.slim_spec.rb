require 'rails_helper'

RSpec.describe "years/show", type: :view do
  before(:each) do
    @year = assign(:year, Year.create!(
      :integer => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
