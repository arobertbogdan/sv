class HomeController < ApplicationController
  def index
    @posts = Post.get_main_posts(params[:category], params[:filter], params[:search])
    @posts = @posts.paginate(:page => params[:page], :per_page => 20)
    @category = params[:category]
    @filter = params[:filter]
  end
end