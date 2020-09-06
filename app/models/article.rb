# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  description :text(65535)
#  title       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Article < ApplicationRecord
  # Uploader
  has_one_base64_attached :thumbnail

  # Relations
  has_many :sections
  accepts_nested_attributes_for :sections, allow_destroy: true

  # Validations
  validates :title, presence: true
  validates :title, length: { maximum: 30 }, if: -> { self.title.present? }
  validates :description, presence: true

  # convert to url when passing to the front
  def thumbnail_url
    rails_blob_path(self.thumbnail) if self.thumbnail.attached?
  end
end
