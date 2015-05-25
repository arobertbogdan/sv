class UsersController < Devise::RegistrationsController
    before_action :authenticate_user!, :except => [:profile]

    def profile
      filter = params[:filter] == nil ? "overvoew" : params[:filter]
      @posts = Post.get_user_posts params[:id], filter
      @user = User.find(params[:id])
      @followers = Follow.get_user_followings params[:id]
      @karma = Post.karma params[:id]
      @filters = {:profile => {:overview => false, :commented => false, :voted => false}}
      @filters.values[0].each { |k, v|
        if k.to_s == filter.to_s
          @filters.values[0][k] = true
        end
      }
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

    def unfollow
      @followed_user = Follow.find_by(:user_id => current_user.id, :follow_id => params[:id].to_i).destroy
      respond_to do |format|
        if @followed_user.save
          format.html { redirect_to profile_path(params[:id].to_i), notice: 'Followed succesfully.' }
        end
      end
    end

    def upload_avatar
      @user = User.find(params[:id])
      respond_to do |format|
        if @user.update(account_update_params)
          format.html { redirect_to profile_path(params[:id].to_i), notice: 'Photo uploaded succesfully.' }
        end
      end
    end

    private

    def sign_up_params
      params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
    end

    def account_update_params
      params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :current_password, :avatar)
    end
end