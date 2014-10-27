class Question < ActiveRecord::Base
  belongs_to :question_set
  has_many :choices

  validates :content, presence: true  
end
