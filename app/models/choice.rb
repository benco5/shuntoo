class Choice < ActiveRecord::Base
  belongs_to :question
  delegate :question_set, :to => :question

  validates :content, presence: true  
end
