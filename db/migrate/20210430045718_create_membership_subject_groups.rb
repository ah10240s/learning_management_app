class CreateMembershipSubjectGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :membership_subject_groups do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :subject_group, null: false, foreign_key: true
      t.datetime :joined_at
      t.datetime :withdrawn_at

      t.timestamps
    end
  end
end
