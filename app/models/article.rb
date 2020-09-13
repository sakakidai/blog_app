# == Schema Information
#
# Table name: articles
#
#  id             :bigint           not null, primary key
#  description    :text(65535)
#  thumbnail_type :integer
#  title          :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Article < ApplicationRecord
  # Uploader
  has_one_base64_attached :image

  # Relations
  has_one :youtube
  has_many :sections
  accepts_nested_attributes_for :youtube, allow_destroy: true, update_only: true
  accepts_nested_attributes_for :sections, allow_destroy: true

  # Enums
  enum thumbnail_type: { youtube: 0, image: 1 }

  # Validations
  validates :title, presence: true
  validates :title, length: { maximum: 30 }, if: -> { self.title.present? }
  validates :description, presence: true

  # convert to url when passing to the front
  def image_url
    rails_blob_path(self.image) if self.image.attached?
  end

  def youtube_url
    self.youtube.url if self.youtube.present?
  end
end
