class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :null_session
  before_action :categories, :user, :user_activity, :authenticate
  
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

  def authenticate
    if  request.format.json?
      return authenticate_token || render_unauthorized
    end
    :authenticate_user!
  end

  def authenticate_token
    authenticate_with_http_token do |token, options| @auth_user = User.find_by(auth_token: token) end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: 'Bad credentials', status: 401
  end
end
