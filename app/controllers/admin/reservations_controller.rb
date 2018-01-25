class Admin::ReservationsController < Admin::Base
  def index
    @reservations = Reservation.changeEndDateFromExtend(0)
  end

  def show
    @reservation = Reservation.find(params[:id])
    @reservationIds = Reservation.searchExtendId(@reservation.member_id, @reservation.room_id, params[:id])
    @reservations = Reservation.joins('JOIN rooms ON rooms.id = reservations.room_id',
                                      'JOIN plans ON reservations.plan_id = plans.id',
                                      'JOIN members ON members.id = reservations.member_id')
                     .select('rooms.room_number, plans.name, members.name, members.user_id, reservations.*').find(@reservationIds)
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @extend_reservation = Reservation.where(start_date: @reservation.end_date).first
    if @extend_reservation.present?
      @extend_reservation.update_attribute(:is_extend, false)
    end
    @reservation.destroy
    redirect_to :reservations, info: '削除しました。'
  end

  def reservation_params
    params.require(:reservation).permit(:room_id, :member_id, :guest_count, :plan_id, :start_date, :end_date)
  end

  def reservation_confirm_params
    params.require(:reservation).permit(:room_id, :member_id, :guest_count, :sum_price, :plan_id, :start_date, :end_date)
  end
end
