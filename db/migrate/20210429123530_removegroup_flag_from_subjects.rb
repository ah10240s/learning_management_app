class RemovegroupFlagFromSubjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :subjects, :group_flag, :boolean
  end
end
