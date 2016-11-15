class User < ApplicationRecord
  has_many :active_relationships, ClassName: Relationship.name,
    foreign_key: "follower_id", dependent: destroy
  has_many :pasive_relationships, ClassName: Relationship.name,
    foreign_key: "followed_id", dependent: destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :pasive_relationships, source: :follower
  has_many :activities, dependent: destroy
  has_many :lessons, dependent: destroy
end
