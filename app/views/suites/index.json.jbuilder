json.array!(@suites) do |suite|
  json.extract! suite, :id, :title
  json.url suite_url(suite, format: :json)
end
