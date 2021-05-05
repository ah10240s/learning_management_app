class RemoveInvitingFlagFromSubjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :subjects, :inviting_flag, :boolean
  end
end
