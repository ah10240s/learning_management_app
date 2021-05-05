class Subject < ApplicationRecord
  belongs_to :user
  has_many :studyplans, dependent: :destroy
  has_many :membership_subject_groups

  validates :user_id, presence: true
  validates :subject_name,
            length: { minimum: 1, maximum: 60 },
            presence: true



  # #####################################
  # その科目が「招待中」の科目グループがあるか判定
  # #####################################
  def invit_subject_group_judge
    # グループテーブルに対象の科目が存在するか確認
    
    subject_groupmember_ships = self.membership_subject_groups
    if subject_groupmember_ships == nil || subject_groupmember_ships.count == 0 then
      return false
    end

    latest_subject_groupmember_ship = subject_groupmember_ships.order(id: :DESC).first

    return latest_subject_groupmember_ship.membership_subject_group_invit

  end

  
  # #####################################
  # その科目が「参加中」の科目グループがあるか判定
  # #####################################
  def joining_subject_group_judge
    # グループテーブルに対象の科目が存在するか確認
    
    subject_groupmember_ships = self.membership_subject_groups
    if subject_groupmember_ships == nil || subject_groupmember_ships.count == 0 then
      return false
    end

    latest_subject_groupmember_ship = subject_groupmember_ships.order(id: :DESC).first

    return latest_subject_groupmember_ship.membership_subject_group_valid

  end


  # #####################################
  # 科目が参加している科目グループを返却 ※「joining_subject_group_judge」がtrueの時のみ実行する
  # #####################################
  def joining_subject_group
    subject_groupmember_ships = self.membership_subject_groups
    latest_subject_groupmember_ships = subject_groupmember_ships.order(id: :DESC).first
    subject_group = SubjectGroup.where(id: latest_subject_groupmember_ships.subject_group_id)
    return subject_group.order(id: :DESC).first
  end



  # # #####################################
  # # その科目グループを自分が作ったか科目別に判定
  # # #####################################
  # def subject_group_create_judge

  #   # subject_groupmember_ship = self.subjectgroupmembership
  #   # if subject_groupmember_ship != true || subject_groupmember_ship.Withdrawn_at =< DateTime.now then
  #   #   return false
  #   # end

  #   # subject_group = SubjectGroup.where(id: subject_groupmember_ship.subjectgroup_id)
  #   # if subject_group.user_id == current_user.id then
  #   #   return true
  #   # else
  #   #   return false
  #   # end


  #   # subject_group = self.subject_groupmember_ship
  #   # if subject_group then
  #   #   if subject_group.user_id == current_user.id then
  #   #     return true
  #   #   else
  #   #     return false
  #   #   end
  #   # else
  #   #   return false
  #   # end

  # end


  # # #####################################
  # # 科目グループに
  # # #####################################
  # def group_participate_subject_judge







  # #   subject_group = self.group
  # #   if subject_group != true then
  # #     return false
  # #   end

  # #   subject_group_memberships = subject_group.group_membership
  # #   if subject_group_memberships != true then
  # #     return false
  # #   end

  # #   subject_group_memberships.each do |buf|
  # #     if buf.user_id == current_user.id then
  # #       return true
  # #     end
  # #   end
  # #   return false
  # end


end