# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Category.create(name: "all")
Category.create(name: "gaming")
Category.create(name: "funny")
Category.create(name: "movies")
Category.create(name: "books")
Category.create(name: "news")
Category.create(name: "sports")

user = User.create! :nickname => 'dev1', :email => 'dev@gmail.com', :password => 'devdevdev', :password_confirmation => 'devdevdev'
user2 = User.create! :nickname => 'dev2', :email => 'dev2@gmail.com', :password => 'devdevdev', :password_confirmation => 'devdevdev'

Follow.create(:user_id => user.id, :follow_id => user2.id)

categories = Category.all

categories.each{ |category|
  5.times{
    p = Post.create(title: "Post"+rand(200).to_s+category.name, description:"test", category_id: category.id, media: "http://www.youtube.com", user_id: user.id, rating: rand(4000)-2000 )
    begin
      object = ::LinkThumbnailer.generate(p.media)
      p.thumbnail = object.images.first.src
      p.save
    rescue Net::HTTP::Persistent::Error
    end
  }
}