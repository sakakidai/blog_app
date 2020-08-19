json.set! :article do
  json.extract! @article, :id, :title, :content, :created_at, :updated_at
end