# json.set! :article do
#   json.extract! @article, :id, :title, :content, :thumbnail, :created_at, :updated_at
# end

json.article do
  json.id  @article.id
  json.title @article.title
  json.content @article.content
  json.thumbnail @article.encode_base64(@article.thumbnail)
  json.created_at @article.created_at
  json.updated_at @article.updated_at
end
