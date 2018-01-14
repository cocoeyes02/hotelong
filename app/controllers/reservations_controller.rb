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
    @member_id = session[:members]
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    room = Room.find_by(id: @reservation.room_id)
    @room_number = room.room_number
    plan = Plan.find_by(id: @reservation.plan_id)
    @plan_name = plan.name
    @room_id = session[:room]
    @member_id = session[:members]
    stay_date = @reservation.end_date - @reservation.start_date
    if @reservation.plan_id.to_i == 1
      sum_price = Room.calculate_sum_price(@reservation.room_id.to_i, @reservation.guest_count.to_i) * stay_date
    else
      plan = Plan.find_by(id: @reservation.plan_id.to_i)
      sum_price = plan.price * stay_date
    end
    @sum_price = sum_price.to_i
  end

  def create
    @reservation = Reservation.new(reservation_confirm_params)
    # 延泊だったら延泊フラグを立てる
    is_extend = Reservation.isExtendOrNot(@reservation.member_id.to_i, @reservation.start_date)
    @reservation.is_extend = is_extend
    if @reservation.save
      redirect_to rooms_path, notice: '宿泊予約が完了しました。'
    else
      redirect_to rooms_path, notice: '予約に失敗しました。運営者までご連絡ください。'
    end
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

  def reservation_confirm_params
    params.require(:reservation).permit(:room_id, :member_id, :guest_count, :sum_price, :plan_id, :start_date, :end_date)
  end
end
