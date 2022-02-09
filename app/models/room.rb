class Room < ApplicationRecord
  has_one_attached :image

  has_many :chats
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms
  has_many :room_users, dependent: :destroy
  belongs_to :owner, class_name: 'User'

  validates :name, presence: true
  validates :introduction, presence: true

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  def is_owned_by?(user)
    owner.id == user.id
  end

end
