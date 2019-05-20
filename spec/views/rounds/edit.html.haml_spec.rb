require 'rails_helper'

RSpec.describe "rounds/edit", type: :view do
  before(:each) do
    @round = assign(:round, Round.create!(
      :episode_id => 1,
      :question_ids => "MyText"
    ))
  end

  it "renders the edit round form" do
    render

    assert_select "form[action=?][method=?]", round_path(@round), "post" do

      assert_select "input[name=?]", "round[episode_id]"

      assert_select "textarea[name=?]", "round[question_ids]"
    end
  end
end
