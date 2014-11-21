class Item < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  validate :image_valid?, if: -> (item) do
    item.image_changed? && item.errors[:image].blank?
  end

  def image_valid?
    content_type = image.file.content_type
    if (
      content_type != 'image/jpeg' &&
      content_type != 'image/png'  &&
      content_type != 'image/gif'
    )
      errors.add(:image, 'Invalid MIME Type')
    end
  end
end
