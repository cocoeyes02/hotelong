class ReservationsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @reservation = Reservation.new()
    # TODO: セッションがなかった時のエラー処理
    @options = session[:options]
    @room_id = session[:room]
    @member_id = session[:member]
  end

  def confirm
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
