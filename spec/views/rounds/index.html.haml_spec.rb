require 'rails_helper'

RSpec.describe "rounds/index", type: :view do
  before(:each) do
    assign(:rounds, [
      Round.create!(
        :episode_id => 2,
        :question_ids => "MyText"
      ),
      Round.create!(
        :episode_id => 2,
        :question_ids => "MyText"
      )
    ])
  end

  it "renders a list of rounds" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
