# :nodoc:
class HomesController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'fullscreen', only: [:streaming]

  def index
  end

  def streaming
  end
end
