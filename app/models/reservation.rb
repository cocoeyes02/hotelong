# == Schema Information
#
# Table name: reservations
#
#  id          :integer          not null, primary key
#  room_id     :integer          not null
#  plan_id     :integer          not null
#  member_id   :integer          not null
#  guest_count :integer          not null
#  sum_price   :integer          not null
#  start_date  :date             not null
#  end_date    :date             not null
#  is_extend   :boolean          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Reservation < ActiveRecord::Base
  has_many :rooms
  has_many :plans
  has_many :members

  def self.isEmptyRoomByRoomNumber(room_number, date)
    # TODO: room_numberとdateの値チェック
    @reservations = Reservation.joins('INNER JOIN rooms ON rooms.id = reservations.room_id')
                      .select('reservations.start_date, reservations.end_date, rooms.room_number')
                      .where(rooms: { room_number: room_number })
    if @reservations.nil?
      return true
    end
    @reservations.each do |reservation|
      # チェックアウト日にチェックインすることはできる
      if reservation.start_date <= date && date < reservation.end_date
        return false
      end
    end
    return true
  end

  def self.emptyRoomNumberListByDate(start_date, end_date)

    @no_empty_room_number_list = Reservation.joins('INNER JOIN rooms ON rooms.id = reservations.room_id')
                      .where('(? <= reservations.start_date AND reservations.start_date < ?) OR (? <= reservations.end_date AND reservations.end_date < ?)',
                             start_date, end_date, start_date, end_date)
                      .pluck(:room_number).uniq
    logger.debug @no_empty_room_number_list
    @empty_room_list = Room.where.not(room_number: @no_empty_room_number_list).pluck(:room_number)
    logger.debug @empty_room_list
    return @empty_room_list
  end
end
