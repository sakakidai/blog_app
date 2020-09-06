json.article do
  json.id  @article.id
  json.title @article.title
  json.description @article.description
  json.thumbnail_url @article.thumbnail_url
  json.created_at @article.created_at
  json.updated_at @article.updated_at

  json.set! :sections do
    json.array! @article.sections do |section|
      json.id  section.id
      json.title section.title
      json.description section.description
      json.photo_url section.photo_url
      json.created_at section.created_at
      json.updated_at section.updated_at
    end
  end
end
