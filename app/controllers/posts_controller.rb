class PostsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  #before_action :authenticate_user!, :except => [:show, :index]
  before_action :authenticate, :except => [:show, :index]
  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new
    @comments = Comment.get_post_comments @post
    if session[:comment_errors]
      session[:comment_errors].each {|error, error_message| @comment.errors.add error, error_message}
      session.delete :comment_errors
    end
    respond_to do |format|
      format.html
      format.json { render :json => {:post => @post, :comments => @comments, :status => 200} }
    end
  end

  # GET /posts/new
  def new
    if current_user == nil
      return redirect_to root_path
    end

    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
    @user = current_user
    @followers = Follow.get_user_followings current_user.id
    @karma = Post.karma current_user.id
    @filters = {:profile => {:overview => false, :commented => false, :voted => false}}
    @filters.values[0].each { |k, v|
      if k.to_s == @filter.to_s
        @filters.values[0][k] = true
      end
    }
  end

  # POST /posts
  # POST /posts.json
  def create
    if current_user.!= nil
      @post = current_user.posts.build(post_params)
    else
      @post = @auth_user.posts.build(post_params)
    end
    @post.save

    if @post.errors.empty?
      begin
        object = ::LinkThumbnailer.generate(@post.media)
        @post.thumbnail = !object.images.first.nil? ? object.images.first.src : "/assets/miss-thumb.png"
      rescue Net::HTTP::Persistent::Error
      end
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to profile_path(current_user.id), notice: 'Post was successfully created.' }
        format.json { render :json => {:post => @post, :status => 200} }
      else
        format.html { render :new }
        format.json { render :json => {:post => @post, :status => 400 } }
      end
    end
end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to profile_path(current_user.id), notice: 'Post was successfully updated.' }
        format.json { render :json => {:post => @post, :status => 200} }
      else
        format.html { render :edit }
        format.json { render :json => {:post => @post, :status => 400 } }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to profile_path(current_user.id), notice: 'Post was successfully destroyed.' }
      format.json { render :json => {notice: 'Post was successfully destroyed.', :status => 200} }
    end
  end

  def upvote
    if current_user.!= nil
    @post.up_vote current_user
    else
    @post.up_vote @auth_user
    end

    render :json => {:data => "OK", :status => 200}
  end

  def downvote
    if current_user.!= nil
      @post.down_vote current_user
    else
      @post.down_vote @auth_user
    end

    render :json => {:data => "OK", :status => 200}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      if request.format.json?
        return params.permit(:title, :description, :media, :category_id)
      end
      params.require(:post).permit(:title, :description, :media, :category_id)
    end
end
