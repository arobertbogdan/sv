class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :categories, :user, :user_activity

  def categories
    @categories = Category.all
  end

  def user
    @user = User.new
  end

  def user_activity
    if user_signed_in?
      activity = Activity.find_by(:user_id => current_user.id)
      if activity == nil
        Activity.create(:user_id => current_user.id)
      else
        activity.updated_at = Time.now
        activity.save
      end
    end
  end
end
