class CreateStudyplans < ActiveRecord::Migration[6.0]
  def change
    create_table :studyplans do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.datetime :start_daytime, null: false
      t.datetime :end_daytime, null: false
      t.boolean :done_flag, default: false, null: false

      t.timestamps
    end
  end
end
