json.article do
  json.id  @article.id
  json.title @article.title
  json.content @article.description
  json.thumbnail @article.thumbnail_url
  json.created_at @article.created_at
  json.updated_at @article.updated_at
end
