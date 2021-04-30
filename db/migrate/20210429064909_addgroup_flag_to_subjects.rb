class AddgroupFlagToSubjects < ActiveRecord::Migration[6.0]
  def change
    add_column :subjects, :group_flag, :boolean, default: false, null: false
  end
end
