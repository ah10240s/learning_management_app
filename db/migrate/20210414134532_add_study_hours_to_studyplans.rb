class AddStudyHoursToStudyplans < ActiveRecord::Migration[6.0]
  def change
    add_column :studyplans, :study_hours, :time, null: false
  end
end
