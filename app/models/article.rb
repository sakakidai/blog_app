# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Article < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64 # to use gem active_storage_base64
  include Rails.application.routes.url_helpers # to use helper rails_blob_path

  #Uploader
  has_one_base64_attached :thumbnail

  # Validations
  validates :title, presence: true
  validates :title, length: { maximum: 30 }, if: -> { self.title.present? }
  validates :content, presence: true

  # convert to url when passing to the front
  def thumbnail_url
    rails_blob_path(self.thumbnail) if self.thumbnail.attached?
  end
end
