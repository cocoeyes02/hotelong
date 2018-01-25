class TopController < ApplicationController
  def index
    if current_member
      redirect_to :rooms
    end
  end
end
