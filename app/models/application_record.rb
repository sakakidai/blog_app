class ApplicationRecord < ActiveRecord::Base
  include ActiveStorageSupport::SupportForBase64 # to use gem active_storage_base64
  include Rails.application.routes.url_helpers # to use helper rails_blob_path
  self.abstract_class = true
end
