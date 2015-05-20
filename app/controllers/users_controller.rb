class UsersController < Devise::RegistrationsController
    def profile
      @posts = Post.get_user_posts params[:id]
      @user_id = params[:id]
    end

    private

    def sign_up_params
      params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
    end

    def account_update_params
      params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :current_password)
    end
end