class RemoveWithdrawnAtFromMembershipSubjectGroups < ActiveRecord::Migration[6.0]
  def change
    remove_column :membership_subject_groups, :withdrawn_at, :datetime
  end
end
