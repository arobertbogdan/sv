class HomeController < ApplicationController
  def index
    @posts = Post.get_main_posts(params[:category], params[:filter], params[:search])
    @category = params[:category]
    @filter = params[:filter]
  end
end