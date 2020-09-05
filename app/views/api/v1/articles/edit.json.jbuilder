json.article do
  json.id  @article.id
  json.title @article.title
  json.description @article.description
  json.thumbnail_url @article.thumbnail_url
  json.created_at @article.created_at
  json.updated_at @article.updated_at
  json.sections JSON.parse(@article.sections.to_json(except: [:article_id, :created_at, :updated_at]))
end