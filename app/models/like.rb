class Like < ActiveRecord::Base
  belongs_to :idea
  attr_accessible :comment
end
