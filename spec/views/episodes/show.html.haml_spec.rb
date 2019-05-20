require 'rails_helper'

RSpec.describe "episodes/show", type: :view do
  before(:each) do
    @episode = assign(:episode, Episode.create!(
      :team_ids => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
  end
end
