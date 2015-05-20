class UsersController < Devise::RegistrationsController
    before_action :authenticate_user!, :except => [:profile]

    def profile
      @posts = Post.get_user_posts params[:id]
      @user_id = params[:id].to_i
      @followers = Follow.get_user_followings params[:id]
      @karma = Post.karma params[:id]
    end

    def follow
      @followed_user = current_user.follows.build()
      @followed_user.follow_id = params[:id].to_i
      respond_to do |format|
        if @followed_user.save
          format.html { redirect_to profile_path(params[:id].to_i), notice: 'Followed succesfully.' }
        end
      end
    end

    private

    def sign_up_params
      params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
    end

    def account_update_params
      params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :current_password)
    end
end