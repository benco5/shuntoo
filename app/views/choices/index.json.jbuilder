json.array!(@choices) do |choice|
  json.extract! choice, :id, :content, :question_id
  json.url choice_url(choice, format: :json)
end
