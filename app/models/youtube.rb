# == Schema Information
#
# Table name: youtubes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :integer
#  video_id   :string(255)
#
class Youtube < ApplicationRecord
  YOUTUBE_BASE_URL = 'https://www.youtube.com/embed/'

  # Relations
  belongs_to :article

  # Validations
  # validates :video_id, presence: true
  # validates :video_id, length: { is: 11 }, if -> { self.video_id.present? }

  # Instance_methods
  def url
    YOUTUBE_BASE_URL + self.video_id
  end
end
