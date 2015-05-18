class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_votes
  has_many :comment_users

  def self.get_user_posts user
    Post.where(:user_id => user.id)
  end

  def up_vote user
    @vote = PostVote.find_by(user_id: user.id, post_id: self.id)
    logger.debug @vote
    apply_vote 1, user
  end

  def down_vote user
    @vote = PostVote.find_by(user_id: user.id, post_id: self.id)
    apply_vote -1, user
  end

  private
    def apply_vote vote_type, user
      if @vote == nil
        @vote = PostVote.create(user_id: user.id, post_id: id)
        @vote.vote_type = vote_type
      else
        if @vote.vote_type + vote_type == 0
          self.rating += 2 * vote_type
        else
          self.rating += @vote.vote_type == vote_type ? -vote_type : vote_type
        end
      end

      @vote.vote_type = @vote.vote_type == vote_type ? 0 : vote_type
      @vote.save
      self.save
    end

end
