class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :categories, :filters

  def categories
    @categories = Category.all
  end

  def filters
    @filters = {:general => {:hot => false, :new => false}}
  end

end
