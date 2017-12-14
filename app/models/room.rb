# == Schema Information
#
# Table name: rooms
#
#  id          :integer          not null, primary key
#  room_id     :integer          not null
#  room_number :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Room < ActiveRecord::Base
end
