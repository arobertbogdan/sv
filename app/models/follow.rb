class Follow < ActiveRecord::Base

  belongs_to :user

  def self.get_user_followings user
    follows = Follow.where(:user_id => user).joins("INNER JOIN users ON users.id = follows.follow_id").select('follows.*','users.*')
  end

  def count_new_posts current_user
  	seconds = (Time.now - user.last_sign_in_at).to_i.abs
  	posts = Post.where('user_id = ? AND created_at < ? AND created_at > ?', self.follow_id, current_user.current_sign_in_at, current_user.last_sign_in_at).count
  end
end
