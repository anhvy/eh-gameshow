require 'rails_helper'

RSpec.describe "questions/new", type: :view do
  before(:each) do
    assign(:question, Question.new(
      :content => "MyText",
      :acceptable_answers => "MyString"
    ))
  end

  it "renders new question form" do
    render

    assert_select "form[action=?][method=?]", questions_path, "post" do

      assert_select "textarea[name=?]", "question[content]"

      assert_select "input[name=?]", "question[acceptable_answers]"
    end
  end
end
