require 'rails_helper'

RSpec.describe "rounds/new", type: :view do
  before(:each) do
    assign(:round, Round.new(
      :episode_id => 1,
      :question_ids => "MyText"
    ))
  end

  it "renders new round form" do
    render

    assert_select "form[action=?][method=?]", rounds_path, "post" do

      assert_select "input[name=?]", "round[episode_id]"

      assert_select "textarea[name=?]", "round[question_ids]"
    end
  end
end
