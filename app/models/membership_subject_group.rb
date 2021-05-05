class MembershipSubjectGroup < ApplicationRecord
  belongs_to :subject
  belongs_to :subject_group

  # #####################################
  # 参加科目グループが有効か（参加中か）判定
  # #####################################
  def membership_subject_group_valid
    
    if self.joined_at == nil then
      return false
    end
    
    if self.withdrawn_at == nil then
      return true
    end
    
    if self.withdrawn_at <= (DateTime.now) - 9.hour then
      return false
    else
      return true
    end

  end

  # #####################################
  # 参加科目グループが保留中（招待中）か判定
  # #####################################
  def membership_subject_group_invit
    if self.joined_at == nil then
      return true
    else
      return false
    end
  end




end