class Question < ActiveRecord::Base
  validates :content, presence: true

  belongs_to :suite

  
end
