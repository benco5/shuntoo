class AddQuestionFormatRefToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :question_format, index: true
  end
end
