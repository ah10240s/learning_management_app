class Subject < ApplicationRecord
  belongs_to :user
  has_many :studyplans, dependent: :destroy
  
  validates :subject_name,
  length: { minimum: 2, maximum: 20 }

end
