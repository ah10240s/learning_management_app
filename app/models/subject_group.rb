class SubjectGroup < ApplicationRecord
  belongs_to :user
  has_many :membership_subject_groups


  # #####################################
  # 科目グループの作成者が自分かどうか判定
  # #####################################
  def subject_groups_create_judge(user)
    create_user_id = self.user_id
    if create_user_id == user.id then
      return true
    else
      return false
    end
  end

  # #####################################
  # 科目グループに参加している参加者を返却
  # #####################################
  def subject_groups_joining_users
    membership_subject_groups = self.membership_subject_groups

    return_date = []
    membership_subject_groups.each do |buf|
      
      if buf.membership_subject_group_valid then
        subject = Subject.find(buf.subject_id)
        return_date << subject.user_id
      end
    end
    
    return return_date
  end


end
