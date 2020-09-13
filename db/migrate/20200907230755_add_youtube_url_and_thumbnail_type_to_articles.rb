class AddYoutubeUrlAndThumbnailTypeToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :thumbnail_type, :integer 
  end
end
