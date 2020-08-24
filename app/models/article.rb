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
  include ActiveStorageSupport::SupportForBase64
  #Uploader
  has_one_base64_attached :thumbnail

  # Validations
  validates :title, presence: true
  validates :title, length: { maximum: 30 }, if: -> { self.title.present? }
  validates :content, presence: true

  # 各モデルのレコードに添付された画像ファイルをBase64でエンコードする
  # TODO: urlにアクセスするように書き直す
  def encode_base64(file)
    return if file.nil?

    image = Base64.encode64(file.download) # 画像ファイルをActive Storageでダウンロードし、エンコードする
    blob  = ActiveStorage::Blob.find(file[:id]) # Blobを作成
    "data:#{blob[:content_type]};base64,#{image}" # Vue側でそのまま画像として読み込み出来るBase64文字列にして返す
  end
end
