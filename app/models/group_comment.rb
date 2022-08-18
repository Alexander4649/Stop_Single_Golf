class GroupComment < ApplicationRecord
  belongs_to :user
  belongs_to :group
  
  validates :comment, presence: true, length: { minimum: 1, maximum: 500 }
end
