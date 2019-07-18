class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :edit, :update, :destroy]
  before_action :fetch_questions, only: [:show, :edit]

  def index
    @rounds = Round.all
  end

  def show; end

  def new
    @round = Round.new
  end

  def edit; end

  def create
    @round = Round.new(round_params)

    respond_to do |format|
      if @round.save
        format.html { redirect_to @round, notice: 'Round was successfully created.' }
        format.json { render :show, status: :created, location: @round }
      else
        format.html { render :new }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @round.update(round_params)
        format.html { redirect_to edit_round_path(@round), notice: 'Round was successfully updated.' }
        format.json { render :show, status: :ok, location: @round }
      else
        format.html { render :edit }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @round.destroy
    respond_to do |format|
      format.html { redirect_to rounds_url, notice: 'Round was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_broadcast_question
    redis = Redis.new
    redis.publish('round:question_id', params[:question_id])
    render status: 200, json: { success: true }
  ensure
    redis.quit
  end

  def set_broadcast_score
    redis = Redis.new
    score = params[:score] == 'reset' ? 0 : redis.get('round:score') + 1
    redis.publish('round:score', score)
    render status: 200, json: { success: true }
  ensure
    redis.quit
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_round
    @round = Round.find(params[:id])
  end

  def fetch_questions
    @questions = Question.find @round.question_ids
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def round_params
    params.require(:round).permit(:episode_id, :question_ids)
  end
end
