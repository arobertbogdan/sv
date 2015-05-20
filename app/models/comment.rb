class Comment < ActiveRecord::Base
  has_many :child, class_name: "Comment",
            foreign_key: "comment_id"

  belongs_to :parent, class_name: "Comment",
             foreign_key: "comment_id"
  belongs_to :user
  belongs_to :post

  scope :root_comments, lambda { |post| where(:post_id => post.id, :comment_id =>  nil).joins(:user).select('comments.*','users.nickname','users.id as reply_user_id') }
  scope :child_comments, -> { joins(:user).select('comments.*','users.nickname','users.id as reply_user_id') }

  def old
    ApplicationHelper.time_diff created_at
  end

  def self.get_post_comments post
    Comment.root_comments post
  end

end
