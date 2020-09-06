# == Schema Information
#
# Table name: sections
#
#  id          :bigint           not null, primary key
#  description :text(65535)
#  title       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  article_id  :bigint
#
# Indexes
#
#  index_sections_on_article_id  (article_id)
#
class Section < ApplicationRecord
  # Uploader
  has_one_base64_attached :photo

  # Relations
  belongs_to :article

  # convert to url when passing to the front
  def photo_url
    rails_blob_path(self.photo) if self.photo.attached?
  end
end
