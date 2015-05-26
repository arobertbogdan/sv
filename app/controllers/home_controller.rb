class HomeController < ApplicationController
  before_action :persist_user

  def index
    filter = params[:filter] == nil ? "hot" : params[:filter]
    @posts = Post.get_main_posts(params[:category], filter, params[:search])
    @posts = @posts.paginate(:page => params[:page], :per_page => 20)
    @category = params[:category] != nil ? Category.friendly.find(params[:category]) : Category.find_by(:name => "all")
    @old_filter = filter
    @filters = {:general => {:hot => false, :new => false}}
    @filters.values[0].each { |k, v|
      if k.to_s == filter.to_s
        @filters.values[0][k] = true
      end
    }

  end

  private

  def persist_user
    if session[:user_errors]
      @has_errors = session[:user_has_errors]
      @user = User.new session[:user_fil]
      session[:user_errors].each {|error, error_message| @user.errors.add error, error_message}
      session.delete :user_errors
      session.delete :user_has_errors
      session.delete :user_fil
    else
      @user = User.new
    end
  end
end