# == Schema Information
#
# Table name: goals
#
#  id         :bigint(8)        not null, primary key
#  user_id    :string           not null
#  state      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#

class Goal < ApplicationRecord
  STATES = %w(public private)
  
  validates :title, :user_id, :state, presence: true
  
  belongs_to :user,
    foreign_key: :user_id,
    class_name: :User
    
  def self.states
    STATES.dup
  end
end
