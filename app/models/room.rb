# == Schema Information
#
# Table name: rooms
#
#  id            :integer          not null, primary key
#  class_room_id :integer          not null
#  room_number   :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Room < ActiveRecord::Base
  has_many :plans, through: :plan_rooms
  has_many :plan_rooms
  belongs_to :reservation

  def self.calculate_sum_price(room_id, guest_count)
    # TODO: room_idとguest_countの値チェック
    @room = Room.joins('JOIN class_rooms ON rooms.class_room_id = class_rooms.id')
               .select('class_rooms.expect_count, class_rooms.person_price, class_rooms.surcharge_rate, class_rooms.discount_rate')
               .where('rooms.id = ?', room_id).first
    if @room.nil?
      # TODO: エラー処理
    end
    sum_price = @room.person_price
    if guest_count < @room.expect_count
      1.upto(@room.expect_count - guest_count) do
        sum_price = sum_price * @room.surcharge_rate
      end
    end
    if guest_count > @room.expect_count
      1.upto(guest_count - @room.expect_count) do
        sum_price = sum_price * @room.discount_rate
      end
    end
    sum_price = sum_price * guest_count
    return sum_price
  end
end
