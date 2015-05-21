class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :post_votes
  has_many :comments

  def self.get_user_posts user
    Post.where(:user_id => user)
  end

  def self.karma user
    sum = 0
    Post.where(user_id: user).each{ |post| sum += post["rating"]}
    sum
  end

  def old
    ApplicationHelper.time_diff created_at
  end

  def count_comments
    "comments " + Comment.where(:post_id => self.id).count.to_s
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

  def self.get_main_posts(category, filter, search)
    if category != nil && category != "all"
      category = Category.friendly.find(category)
      @posts = Post.where("category_id = ?", category.id).all
    else
      @posts = Post.all
    end
    if search != nil
      @posts = @posts.select{ |post| (post.description.include?(search)) || (post.title.include?(search)) }
    end
    if filter != nil
      @filter = filter
      case @filter
        when "hot"
          @posts = @posts.sort_by{ |hsh| hsh["rating"] }.reverse
        when "new"
          @posts = @posts.sort_by{ |hsh| (Time.now - hsh["created_at"]).to_i.abs }
      end
    end

    @posts
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
