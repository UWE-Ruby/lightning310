json.array!(@topics) do |topic|
  json.extract! topic, :id, :student_id, :title, :description, :proposed_date, :completed_date, :approved
  json.url topic_url(topic, format: :json)
end
