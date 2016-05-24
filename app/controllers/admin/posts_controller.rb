class Admin::PostsController < Admin::BaseController

  protect_from_forgery with: :null_session
  before_action :authenticate_admin, :set_post

  def all
    @posts = Post.all
    render :json => {:posts => @posts, :status => 200}
  end

  def destroy
    @post.destroy

    render :json => {message: 'Post deleted with success!', status: 200}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end
end