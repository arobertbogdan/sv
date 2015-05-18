class PostVote < ActiveRecord::Base
  scope :post_voted , lambda { |user_id, post_id|
                      find_by(user_id: user_id, post_id: post_id) }

  belongs_to :user
  belongs_to :post
end
