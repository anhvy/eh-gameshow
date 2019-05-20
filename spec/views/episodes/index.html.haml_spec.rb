require 'rails_helper'

RSpec.describe "episodes/index", type: :view do
  before(:each) do
    assign(:episodes, [
      Episode.create!(
        :team_ids => "MyText"
      ),
      Episode.create!(
        :team_ids => "MyText"
      )
    ])
  end

  it "renders a list of episodes" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
