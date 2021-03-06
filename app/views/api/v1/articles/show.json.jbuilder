json.article do
  json.id  @article.id
  json.title @article.title
  json.description @article.description
  json.thumbnail_type @article.thumbnail_type
  json.image_url @article.image_url
  json.youtube_url @article.youtube_url
  json.created_at @article.created_at
  json.updated_at @article.updated_at

  json.set! :sections do
    json.array! @article.sections.with_attached_photo do |section|
      json.id  section.id
      json.title section.title
      json.description section.description
      json.photo_url section.photo_url
      json.created_at section.created_at
      json.updated_at section.updated_at
    end
  end
end
