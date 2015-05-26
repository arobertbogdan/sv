class UsersController < Devise::RegistrationsController
    before_action :authenticate_user!, :except => [:profile]
    before_action :side_bar_resources, :except => [:create]

    def profile
      @posts = Post.get_user_posts params[:id], @filter
    end

    def edit

    end

    def create
      @user = User.create(sign_up_params)
      respond_to do |format|
        if @user.save
          sign_in(:user, @user)
          format.html { redirect_to root_path, notice: 'User was successfully created.' }
        else
          if @user.errors.any?
            session[:user_fil] = @user
            session[:user_errors] = @user.errors
            session[:user_has_errors] = true
          end
          format.html { redirect_to  root_path }
        end
      end
    end

    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      @user = User.find(params[:id])
      if @user.valid_password?(params[:user][:current_password].to_s)
        if @user.update(account_update_params)
          redirect_to profile_path(@user)
        else
          render :edit
        end
      else
        @user.errors.add :current_password, "is blank or invalid"
        render :edit
      end
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
      params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
    end

    def side_bar_resources
      @filter = params[:filter] == nil ? "overview" : params[:filter]
      @user = User.find(params[:id])
      @followers = Follow.get_user_followings params[:id]
      @karma = Post.karma params[:id]
      @filters = {:profile => {:overview => false, :commented => false, :voted => false}}
      @filters.values[0].each { |k, v|
        if k.to_s == @filter.to_s
          @filters.values[0][k] = true
        end
      }
    end
end