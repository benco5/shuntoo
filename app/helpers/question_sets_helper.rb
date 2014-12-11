module QuestionSetsHelper

  def session_for_new_response_token
    session[:show_modal] = true
    session[:question_set_id] = @question_set.id
    session[:response_tokens] ||= {}
    session[:response_tokens][@question_set.id] = @question_set.response_token
  end
end
