class Subject < ApplicationRecord
  belongs_to :user
  has_many :studyplans, dependent: :destroy
  
  validates :user_id, presence: true
  validates :subject_name,
            length: { minimum: 1, maximum: 60 },
            presence: true

end
