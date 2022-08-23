class RemoveReserveUser < ApplicationRecord
  belongs_to :user
end

# 外部のIDを持っているモデルはbelongs_to
# 持っていないモデルにはhas_one 