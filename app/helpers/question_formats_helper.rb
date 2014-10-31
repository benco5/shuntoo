module QuestionFormatsHelper

  def set_question_formats
    @question_formats = QuestionFormat.all
  end
  
end
