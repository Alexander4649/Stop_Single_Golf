class GroupUser < ApplicationRecord
  
  GROUP_USER_LIMIT = 4 # 制限する人数 : この記述を「定数を切る」とゆう
  
  belongs_to :user
  belongs_to :group
  
  validate :check_number_of_users #グループ人数を制限
  
  def check_number_of_users
    # --- 保存前のためGROUP_USER_LIMITから-1する
    current_users_count = GroupUser.where(group_id: group_id).count
    errors.add(:group, "人数OVER") if current_users_count > GROUP_USER_LIMIT - 1
  end
  
end
