json.array!(@facts) do |fact|
  json.extract! fact, :id, :text
  json.url fact_url(fact, format: :json)
end
