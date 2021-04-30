class CreateSubjectGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :subject_groups do |t|
      t.references :user, null: false, foreign_key: true
      t.text :name, null: false

      t.timestamps
    end
  end
end
