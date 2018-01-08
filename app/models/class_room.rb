# == Schema Information
#
# Table name: class_rooms
#
#  id             :integer          not null, primary key
#  person_price   :integer          not null
#  style_name     :string           not null
#  expect_count   :integer          not null
#  can_add_bed    :boolean          not null
#  discount_rate  :float            default(1.0), not null
#  surcharge_rate :float            default(1.0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ClassRoom < ActiveRecord::Base
  belongs_to :room
end
