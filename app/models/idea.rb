class Idea < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  attr_accessible :description, :name, :picture
  has_many :likes
  scope :top5,
    select("ideas.id, ideas.name, ideas.description, count(likes.id) AS likes_count").
    joins(:likes).
    group("ideas.id").
    order("likes_count DESC").
    limit(5)
end
