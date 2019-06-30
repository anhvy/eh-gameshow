class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :edit, :update, :destroy]
  include ActionController::Live

  def index
    @rounds = Round.all
  end

  def show
    @questions = Question.find @round.question_ids
  end

  def new
    @round = Round.new
  end

  def edit
  end

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
        format.html { redirect_to @round, notice: 'Round was successfully updated.' }
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

  def broadcasted_question
    redis = Redis.new
    sse = SSE.new(response.stream)
    response.headers['Content-Type'] = 'text/event-stream'
    redis.subscribe('round:question_id') do |on|
      on.message do |e, data|
        question = Question.find(data)
        sse.write(question.content)
      end
    end
  rescue IOError
  ensure
    redis.quit
    sse.close
  end

  def current_score
    redis = Redis.new
    sse = SSE.new(response.stream)
    response.headers['Content-Type'] = 'text/event-stream'
    redis.subscribe('round:score') do |on|
      on.message do |e, data|
        sse.write(data)
      end
    end
  rescue IOError
  ensure
    redis.quit
    sse.close
  end

  def set_broadcast_question
    redis = Redis.new
    redis.publish('round:question_id', params[:question_id])
    redis.quit
    render status: 200, json:{success: true}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_round
    @round = Round.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def round_params
    params.require(:round).permit(:episode_id, :question_ids)
  end
end
