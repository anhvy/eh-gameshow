require 'rails_helper'

RSpec.describe "questions/edit", type: :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      :content => "MyText",
      :acceptable_answers => "MyString"
    ))
  end

  it "renders the edit question form" do
    render

    assert_select "form[action=?][method=?]", question_path(@question), "post" do

      assert_select "textarea[name=?]", "question[content]"

      assert_select "input[name=?]", "question[acceptable_answers]"
    end
  end
end
