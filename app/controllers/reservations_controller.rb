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
    @reservation = Reservation.new(reservation_params)
    room = Room.find_by(id: @reservation.room_id)
    @room_number = room.room_number
    plan = Plan.find_by(id: @reservation.plan_id)
    @plan_name = plan.name

    stay_date = @reservation.end_date - @reservation.start_date
    if @reservation.plan_id.to_i == 1
      @sum_price = Room.calculate_sum_price(@reservation.room_id, @reservation.guest_count) * stay_date
    else
      @sum_price = Plan.where(id: @reservation.plan_id.to_i).pluck(:price) * stay_date
    end
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def reservation_params
    params.require(:reservation).permit(:room_id, :member_id, :guest_count, :plan_id, :start_date, :end_date)
  end
end
