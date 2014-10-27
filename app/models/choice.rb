class Choice < ActiveRecord::Base
  belongs_to :question
  delegate :question_set, :to => :question
end
