class Question < ActiveRecord::Base
  belongs_to :question_set

  validates :content, presence: true  
end
