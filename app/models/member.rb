# == Schema Information
#
# Table name: members
#
#  id              :integer          not null, primary key
#  user_id         :string           not null
#  hashed_password :string           not null
#  name            :string           not null
#  sex             :integer          not null
#  address         :string           not null
#  tel             :string           not null
#  birthday        :date             not null
#  email           :string           not null
#  admin_authority :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Member < ActiveRecord::Base
  belongs_to :reservation
  attr_accessor :password

  def password=(val)
    if val.present?
      self.hashed_password = BCrypt::Password.create(val)
    end
    @password = val
  end
end
