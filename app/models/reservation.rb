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
  validates :room_id, presence: true,
            numericality: { only_integer: true }
  validates :plan_id, presence: true,
            numericality: { only_integer: true }
  validates :member_id, presence: true,
            numericality: { only_integer: true }
  validates :guest_count, presence: true,
            numericality: { only_integer: true }
  validates :sum_price, presence: true,
            numericality: { only_integer: true }
  validates :start_date, presence: true
  validates :end_date, presence: true

  def self.searchExtendId(member_id, room_id, first_id)
    extendIds = []
    @reservation = Reservation.find(first_id)
    while @reservation.present?
      insertId = @reservation.id
      extendIds.push(insertId)
      @reservation = Reservation.where(member_id: member_id, room_id: room_id, start_date: @reservation.end_date).first
    end
    logger.debug(extendIds)
    return extendIds
  end

  def self.changeEndDateFromExtend(member_id)
    puts member_id
    if member_id != 0
      @reservations = Reservation.joins('JOIN rooms ON rooms.id = reservations.room_id').select('reservations.*, rooms.room_number').where(member_id: member_id)
    else
      # 管理画面は全部表示
      @reservations = Reservation.joins('INNER JOIN rooms ON rooms.id = reservations.room_id',
                                        'INNER JOIN members ON members.id = reservations.member_id').select('reservations.*, rooms.room_number, members.name, members.user_id')
    end
    @reservations.each do |reservation|
      # 連泊している宿泊データは結合する
      if reservation.is_extend == false
        if member_id == 0
          # 管理画面は全部表示
          @extend_reservation = @reservations.where(is_extend: true, member_id: reservation.member_id)
        else
          @extend_reservation = @reservations.where(is_extend: true, member_id: member_id)
        end
        if @extend_reservation.present?
          @extend_reservation.each do |extend|
            # 部屋が同じで宿泊期間が隣接していたら同じ宿泊データとして宿泊機関を結合する
            if extend.start_date == reservation.end_date && extend.room_id == reservation.room_id
              reservation.end_date = extend.end_date
              reservation.sum_price += extend.sum_price
            end
          end
        end
      end
    end
    return @reservations
  end
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

  def self.isExtendOrNot(member_id, start_date)
    @reservation = Reservation.where(member_id: member_id, end_date: start_date)
    if @reservations.present?
      return true
    end
    return false
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
