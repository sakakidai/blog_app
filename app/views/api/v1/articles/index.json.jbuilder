json.set! :articles do
  json.array! @articles do |article|
    json.id  article.id
    json.title article.title
    json.content article.description
    json.thumbnail_type article.thumbnail_type
    json.youtube_url article.youtube_url
    json.thumbnail_url article.thumbnail_url
    json.created_at article.created_at
    json.updated_at article.updated_at
  end
end
json.total_pages @articles.total_pages
