class SubjectGroup < ApplicationRecord
  belongs_to :user
  has_many :membership_subject_groups, dependent: :destroy


  # #####################################
  # この科目グループに所属している、招待中の全ユーザーの科目を返却
  # #####################################
def belongto_invite_alluser_subjects
  membership_subject_groups = self.membership_subject_groups

  return_date = []

  membership_subject_groups.each do |buf|
    if buf.membership_subject_group_invit then
      return_date << Subject.find(buf.subject_id)
    end
  end

  return return_date
end




  # #####################################
  # この科目グループに所属している、招待中の自分の所属科目グループを返却
  # #####################################
  def belongto_invite_membership_subject_groups(user)
    membership_subject_groups = self.membership_subject_groups
    subjects = user.subjects

    membership_subject_groups.each do |buf|
      if buf.membership_subject_group_invit then
        if subjects.exists?(buf.subject_id) then
          return buf
        end
      end
    end

    return nil
  end


  # #####################################
  # この科目グループのうち、所属科目グループにデータがある自分の科目を返却
  # #####################################
  def subject_groups_createuser_subject(user)

    membership_subject_groups = self.membership_subject_groups
    subjects = user.subjects

    membership_subject_groups.each do |buf|
      if subjects.exists?(buf.subject_id) then
        subject = subjects.find(buf.subject_id)
        return subject
      end
    end

    return nil

  end


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
  # 科目グループに参加している全参加者を返却（招待中は含まない）
  # #####################################
  def subject_groups_joining_users
    membership_subject_groups = self.membership_subject_groups

    return_date = []
    membership_subject_groups.each do |buf|
      
      if buf.membership_subject_group_valid then
        subject = Subject.find(buf.subject_id)
        # return_date << subject.user_id
        return_date << User.find(subject.user_id)

      end
    end
    
    return return_date
  end

  # #####################################
  # この科目グループに招待されているユーザーを返却
  # #####################################
  def subject_groups_inviting_users
    membership_subject_groups = self.membership_subject_groups

    return_date = []
    membership_subject_groups.each do |buf|
      
      if buf.membership_subject_group_invit then
        subject = Subject.find(buf.subject_id)
        # return_date << subject.user_id
        return_date << User.find(subject.user_id)
      end
    end
    return return_date
  end



  # #####################################
  # 科目グループに参加している作成者を除いた参加者を返却
  # #####################################
  def subject_groups_joining_notcreate_users
    membership_subject_groups = self.membership_subject_groups

    return_date = []
    membership_subject_groups.each do |buf|
      
      if buf.membership_subject_group_valid then
        subject = Subject.find(buf.subject_id)
        user = User.find(subject.user_id)
        if user.id != self.user.id then
          return_date << user
        end
      end
    end
    return return_date
  end



end

  # # #####################################
  # # 科目グループ作成者の科目を返却（未完成）
  # # #####################################
  # def subject_groups_createuser_subject
  #   # 作成者の科目一覧を取得
  #   create_group_user = self.user
  #   subjects = create_group_user.subjects
  #   # 科目グループに所属しているデータを取得
  #   membership_subject_groups = self.membership_subject_groups.order(id: :DESC)

  #   membership_subject_groups.each do |buf|
  #     if subjects.find(buf.subject_id) then
  #       subject = Subject.find(buf.subject_id)
  #       return subject
  #     end
  #   end

  #   return nil

  # end
