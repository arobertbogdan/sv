class Admin::UsersController < Admin::BaseController

  protect_from_forgery with: :null_session
  before_action :authenticate_admin, :set_user

  def all
    @users = User.all
    render :json => {:users => @users, :status => 200}
  end

  def destroy
    if @user.admin
      return render :json => {message: 'Cannot delete admin users!', status: 403}
    end

    @user.destroy

    render :json => {message: 'User deleted with succes!', status: 200}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
end