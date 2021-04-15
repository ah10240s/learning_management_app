class RemoveEnddaytimeFromStudyplans < ActiveRecord::Migration[6.0]
  def change
    remove_column :studyplans, :end_daytime, :datetime
  end
end
