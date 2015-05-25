class HomeController < ApplicationController
  def index
    filter = params[:filter] == nil ? "hot" : params[:filter]
    @posts = Post.get_main_posts(params[:category], filter, params[:search])
    @posts = @posts.paginate(:page => params[:page], :per_page => 20)
    @category = params[:category] != nil ? Category.friendly.find(params[:category]) : Category.find_by(:name => "all")
    @old_filter = filter
    @filters.values[0].each { |k, v|
      if k.to_s == filter.to_s
        @filters.values[0][k] = true
      end
    }
  end
end