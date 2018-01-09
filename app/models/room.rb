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
               .select('rooms.*, class_rooms.*')
               .where('rooms.id = ?', room_id).first
    if @room.nil?
      # TODO: エラー処理
    end
    puts @room
    sum_price = @room.person_price * guest_count
    if guest_count > @room.person_price
      0.upto(guest_count - @room.person_price) do
        sum_price = sum_price * @room.surcharge_rate
      end
    end
    if guest_count < @room.person_price
      0.upto(@room.person_price - guest_count) do
        sum_price = sum_price * @room.discount_rate
      end
    end
    return sum_price
  end
end
