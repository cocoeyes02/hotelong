class PlansController < ApplicationController
  def index
    if !current_member
      redirect_to :root, danger: 'ログインしてください。'
    end
    @plans = Plan.all
  end
end
