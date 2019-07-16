# :nodoc:
class BroadcastsController < ApplicationController
  include ActionController::Live

  skip_before_action :authenticate_user!

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
end
