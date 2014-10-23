class QuestionSet < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  
  validates :title, presence: true, uniqueness: true
end
