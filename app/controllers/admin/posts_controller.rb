class Admin::PostsController < Admin::BaseController

  protect_from_forgery with: :null_session
  before_action :authenticate_admin

  def all
    @posts = Post.all
    render :json => {:posts => @posts, :status => 200}
  end


end