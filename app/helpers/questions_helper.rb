module QuestionsHelper

  def build_responses_array_for(question)
    responses = []
    question.choices.each do |choice|
      responses << choice.responses.build
    end
    responses
  end


  def response_chart_data_for(question)
    question.choices.map do |choice|
      {
        choice_content: choice.content,
        pip_sum: Response.where("choice_id = ?", choice.id).sum("pip")
      }
    end
  end
end
