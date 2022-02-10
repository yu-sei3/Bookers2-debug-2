class Room < ApplicationRecord
  has_one_attached :image
  belongs_to :owner, class_name: 'User'

  has_many :chats
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms
  has_many :room_users, dependent: :destroy

  validates :name, presence: true
  validates :introduction, presence: true

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  def is_owned_by?(user)
    owner.id == user.id
  end

  def includesUser?(user)
    group_users.exists?(user_id: user.id)
  end

end
