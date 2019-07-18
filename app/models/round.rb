class Round < ApplicationRecord
  belongs_to :episode
  before_save :conver_datatype_to_array, only: [:update]

  def conver_datatype_to_array
    debugger
    self.question_ids = question_ids.split(',')
  end
end
