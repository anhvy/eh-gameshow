class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]
  before_action :set_round, only: %i[assign remove]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def assign
    fetch_questions.then { return } if request.get?

    if assign_question
      flash[:notice] = 'Assigned question successfully!'
    else
      flash[:alert] = 'Assign question failed!'
    end

    redirect_to assign_questions_path(round: @round)
  end

  def remove
    # waiting
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def set_round
    @round = Round.where(id: params[:round]).take
  end

  def question_params
    params.require(:question).permit(:content, :acceptable_answers)
  end

  def fetch_questions
    @questions = Question.all
  end

  def assign_question
    return false if @round.question_ids.include?(params[:question])

    @round.tap { |r| r.question_ids << params[:question] }
    @round.save
  end
end
