class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  scope :following_ids, (lambda do |id_user|
    select(:followed_id).where(follower_id: id_user)
  end)
end
