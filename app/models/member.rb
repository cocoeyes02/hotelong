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

  class << self
    def password=(val)
      if val.present?
        self.hashed_password = BCrypt::Password.create(val)
      end
      @password = val
    end

    def authenticate(user_id, password)
      member = find_by(user_id: user_id)
      if member && member.hashed_password.present? &&
        BCrypt::Password.new(member.hashed_password) == password
        member
      else
        nil
      end
    end
  end
end
