class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, :except => [:show, :index]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.get_user_posts current_user
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = current_user.comments.build
    @comments = Comment.get_post_comments @post
    if session[:comment_errors]
      session[:comment_errors].each {|error, error_message| @comment.errors.add error, error_message}
      session.delete :comment_errors
    end
    respond_to do |format|
      format.html
    end
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)
    begin
      object = ::LinkThumbnailer.generate('http://' + @post.media)
      @post.thumbnail = object.images.first.src
    rescue Net::HTTP::Persistent::Error
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to profile_path(current_user.id), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to profile_path(current_user.id), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to profile_path(current_user.id), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @post.up_vote current_user
    render :json => {:data => "OK", :status => 200}
  end

  def downvote
    @post.down_vote current_user
    render :json => {:data => "OK", :status => 200}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :media, :category_id)
    end
end
