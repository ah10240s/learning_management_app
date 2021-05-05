class AddInvitingFlagToSubjects < ActiveRecord::Migration[6.0]
  def change
    add_column :subjects, :inviting_flag, :boolean, default: false, null: false
  end
end
