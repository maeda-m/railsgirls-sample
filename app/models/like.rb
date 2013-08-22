class Like < ActiveRecord::Base
  belongs_to :idea
  belongs_to :user
  attr_accessible :comment, :user_id
end
