class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :user_rooms
  has_many :chats

  validates :name, presence: true, length: {minimum: 2, maximum: 20}
  validates :introduction, length: {maximum: 50}
  attachment :profile_image

  # フォロー機能
  has_many :relationships,class_name:"Relationship", foreign_key:"follower_id", dependent: :destroy
  has_many :reverse_of_relationships,class_name:"Relationship", foreign_key:"followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

def follow(a)
 relationships.create!(followed_id: a)
end

def unfollow(user_id)
  relationships.find_by(followed_id:user_id).destroy
end

def followings?(user)
followings.include?(user)
end

include JpPrefecture
jp_prefecture :prefecture_code

def prefecture_name
  JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
end

def prefecture_name=(prefecture_name)
  self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
end

end
