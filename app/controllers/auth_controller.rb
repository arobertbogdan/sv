class AuthController < ActionController::Base
  def token
    @user = User.find_by_email(params[:email])
    if @user && @user.valid_password?(params[:password])
      render :json => {:token => @user[:auth_token], :status => 200}
    else
      render :json => {:token => "Invalid credentials!", :status => 500}
    end
  end
end
