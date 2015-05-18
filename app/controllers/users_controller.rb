class UsersController < Devise::RegistrationsController
    def profile
      @posts = Post.get_user_posts current_user
   end
end