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
end
