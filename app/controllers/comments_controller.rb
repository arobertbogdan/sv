class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # POST /comments/1/reply

  def reply
    if current_user.!= nil
      @comment = current_user.comments.build(comment_params)
    else
      @comment = @auth_user.comments.build(comment_params)
    end
    post = Post.find(params[:post_id])
    @comment.post = post
    if params[:parent_id].!= nil
      parent = Comment.find(params[:parent_id])
      @comment.parent = parent
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to  post_path(post.id), notice: 'Comment was successfully created.' }
        format.json { render :json => {:comment => @comment, :status => 200} }
      else
        if @comment.errors.any?
          session[:comment_errors] = @comment.errors
        end
        format.html { redirect_to  post_path(post.id) }
        format.json { render :json => {:comment => @comment, :status => 400 } }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :json => {:comment => @comment, :status => 200} }
      else
        format.html { render :edit }
        format.json { render :json => {:comment => @comment, :status => 400 } }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { render :json => {:notice => 'Comment was successfully destroyed.', :status => 200} }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      if request.format.json?
        return params.permit(:post_id, :body)
      end
      params.require(:comment).permit(:user_id, :post_id, :body)
    end
end
