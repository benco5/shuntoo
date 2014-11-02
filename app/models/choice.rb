class Choice < ActiveRecord::Base
  has_many :responses
  belongs_to :question
  delegate :question_set, :to => :question

  accepts_nested_attributes_for :responses

  validates :content, presence: true  
end
