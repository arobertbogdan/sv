class SubscribeMailer < ApplicationMailer
  def subscribe_on_category user, category
    @user = user
    @category = category
    mail :to => user.email, :from => "theinternetsv@gmail.com", :subject => "TheInternet " + category.name + " subscribe"
  end
end
