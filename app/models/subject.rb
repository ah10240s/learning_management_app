class Subject < ApplicationRecord
  belongs_to :user

  validates :subject_name,
  length: { minimum: 2, maximum: 20 }

end
