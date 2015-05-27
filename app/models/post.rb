class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates_format_of :media, :with => /\A(http|https)?:?\/?\/?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\Z/ix



  before_save :process_media

  belongs_to :user
  belongs_to :category
  has_many :post_votes
  has_many :comments

  def self.get_user_posts user, filter
    posts = Post.where(:user_id => user).order(created_at: :desc)
    if filter != nil
      case filter
        when "commented"
          comments = Comment.where(:user_id => user).includes(:post)
          posts = []
          comments.each do |comment|
            if !comment.post.nil?
              posts.push(comment.post)
            end
          end
          posts = posts.sort_by{|a| a[:created_at]}.reverse
        when "voted"
          votes = PostVote.where(:user_id => user).where.not(vote_type: 0).includes(:post)
          posts = []
          votes.each do |vote|
            if !vote.post.nil?
              posts.push(vote.post)
            end
          end
          posts = posts.sort_by{|a| a[:created_at]}.reverse
      end
    end
    posts.uniq
  end

  def self.karma user
    sum = 0
    Post.where(user_id: user).each{ |post| sum += post["rating"]}
    sum
  end

  def remote_file_exists?(url)
    return /([^\s]+(\.(?i)(jpg|png|gif|bmp))$)/.match(url)
  end

  def user_vote user
    if user.nil?
      return 0
    end
    vote = PostVote.find_by(:user_id => user.id, :post_id => id)
    vote == nil ? 0 : vote.vote_type
  end

  def count_comments
    "comments " + Comment.where(:post_id => self.id).count.to_s
  end

  def up_vote user
    @vote = PostVote.find_by(user_id: user.id, post_id: id)
    apply_vote 1, user
  end

  def down_vote user
    @vote = PostVote.find_by(user_id: user.id, post_id: id)
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

  def process_media
    if (self.media.include? "http://") == false && (self.media.include? "https://") == false
      self.media = "http://" + self.media
    end
  end

    def apply_vote vote_type, user
      if @vote == nil
        @vote = PostVote.create(user_id: user.id, post_id: id, vote_type: vote_type)
        self.rating += vote_type
      else
        if @vote.vote_type + vote_type == 0
          self.rating += 2 * vote_type
        else
          self.rating += @vote.vote_type == vote_type ? -vote_type : vote_type
        end
        @vote.vote_type = @vote.vote_type == vote_type ? 0 : vote_type
      end

      @vote.save
      self.save
    end

end
