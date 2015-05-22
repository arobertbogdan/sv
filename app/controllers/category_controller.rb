class CategoryController < ApplicationController
  before_action :authenticate_user!

  def subscribe
    subscribe = Subscribe.new(:user_id => params[:user_id], :category_id => params[:category_id])
    subscribe.save
    SubscribeMailer.subscribe_on_category(subscribe.user, subscribe.category).deliver
    respond_to do |format|
      format.html { redirect_to root_path}
      format.json { head :no_content }
    end
  end

  def unsubscribe

  end
end