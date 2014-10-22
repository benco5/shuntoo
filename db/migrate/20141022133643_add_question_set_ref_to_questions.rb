class AddQuestionSetRefToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :question_set, index: true
  end
end
