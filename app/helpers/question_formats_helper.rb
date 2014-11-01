module QuestionFormatsHelper

  def set_question_formats
    @question_formats = QuestionFormat.all
  end

  def set_question_format
    @question_format = @question.question_format
  end
  
end
