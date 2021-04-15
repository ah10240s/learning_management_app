class AddEnddaytimeToStudyplans < ActiveRecord::Migration[6.0]
  def change
    add_column :studyplans, :end_daytime, :datetime, null: false
    remove_column :studyplans, :study_hours, :time
  end
end
