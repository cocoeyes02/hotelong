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
end
