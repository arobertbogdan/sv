class HomeController < ApplicationController
  def index
    @posts = Post.all
    if params[:search] != nil
    	like_keyword = "%#{params[:search]}%"
    	@posts = Post.where('description LIKE ? OR title LIKE ?',like_keyword, like_keyword)
	end
	if params[:filter] != nil
		@filter = params[:filter]
		case @filter
			when "hot"
				@posts = @posts.sort_by{ |hsh| hsh["rating"] }.reverse
			when"new"
				@posts = @posts.sort_by{ |hsh| (Time.now - hsh["created_at"]).to_i.abs }
		end
	end
  end
end