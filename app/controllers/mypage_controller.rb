class MypageController < ApplicationController
  def index
    if !current_member
      redirect_to :root, danger: 'ログインしてください。'
    end
  end
end
