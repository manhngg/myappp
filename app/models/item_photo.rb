class ItemPhoto < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :product, optional: true
end
