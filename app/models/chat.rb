class Chat < ApplicationRecord
   
   IMAGE_FILE_LIMIT = 5
   
   belongs_to :user
   belongs_to :room
   
   validates :message, presence: true, length: { minimum: 1, maximum: 500 }
   validate :images_amount
   
   mount_uploaders :images, ImageUploader
   
   
   def images_amount
    if images.length > IMAGE_FILE_LIMIT
      # images.purge
      errors.add(:images, "は5枚以内にしてください")
    end
   end
   
end