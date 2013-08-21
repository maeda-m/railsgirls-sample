class Idea < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  attr_accessible :description, :name, :picture
  has_many :likes
  belongs_to :user

  # scope :top5,
  #   select("ideas.id, ideas.name, ideas.description, count(likes.id) AS likes_count").
  #   joins(:likes).
  #   group("ideas.id").
  #   order("likes_count DESC").
  #   limit(5)

  def self.top5
    ranking = Idea.all.sort_by do |idea|
      idea.rank
    end

    ranking = ranking.keep_if do |idea|
      idea.rank <= 5
    end

    return ranking
  end

  def rank
    ranking = Idea.all.collect do |idea|
      idea.likes.count
    end

    self_likes_count = self.likes.count

    high_rank_ideas = ranking.keep_if do |likes_count|
      likes_count > self_likes_count
    end

    return high_rank_ideas.count + 1
  end
end
