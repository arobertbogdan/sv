class CategoryController < ApplicationController
  before_action :authenticate_user!

  def subscribe
    subscribe = Subscribe.new(:user_id => current_user.id, :category_id => params[:category_id])
    subscribe.save
    Category.delay.deliver_subscribe_mail(subscribe)
    render :json => {:data => "OK", :status => 200}
  end

  def unsubscribe
    subscribe = Subscribe.find_by(:user_id => current_user.id, :category_id => params[:category_id]).destroy
    subscribe.save
    Category.delay.deliver_unsubscribe_mail(subscribe)
    render :json => {:data => "OK", :status => 200}
  end
end