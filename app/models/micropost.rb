class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :content, presence: true,
    length: {maximum: Settings.Micropost.maximum_content}
  validate :picture_size

  scope :order_micropost, ->{order created_at: :desc}
  scope :micropost_other, (lambda do |id_user|
    where(user_id: Relationship.following_ids(id_user))
      .or where(user_id: id_user)
  end)

  def picture_size
    return unless picture.size > Settings.Micropost.picture_size.megabytes
    errors.add :picture, I18n.t("micropost_model.error_picture")
  end
end
