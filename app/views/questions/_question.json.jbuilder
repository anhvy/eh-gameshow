json.extract! question, :id, :content, :acceptable_answers, :created_at, :updated_at
json.url question_url(question, format: :json)
