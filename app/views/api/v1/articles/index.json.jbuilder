json.set! :articles do
  json.array! @articles do |article|
    json.extract! article, :id, :title, :content, :created_at, :updated_at
  end
end
