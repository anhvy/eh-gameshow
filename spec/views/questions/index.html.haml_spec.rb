require 'rails_helper'

RSpec.describe "questions/index", type: :view do
  before(:each) do
    assign(:questions, [
      Question.create!(
        :content => "MyText",
        :acceptable_answers => "Acceptable Answers"
      ),
      Question.create!(
        :content => "MyText",
        :acceptable_answers => "Acceptable Answers"
      )
    ])
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Acceptable Answers".to_s, :count => 2
  end
end
