class HomeController < ApplicationController
  def index
    @posts = Post.all
    if params[:search] != nil
    	like_keyword = "%#{params[:search]}%"
    	@posts = Post.where('description LIKE ? OR title LIKE ?',like_keyword, like_keyword)
	end
  end
end