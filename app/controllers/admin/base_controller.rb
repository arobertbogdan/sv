class Admin::BaseController < ApplicationController
  def authenticate_admin
      authenticate_admin_token || render_unauthorized
  end

  def authenticate_admin_token
    authenticate_with_http_token do |token, options| @auth_user = User.find_by(auth_token: token, admin: true) end
  end
end