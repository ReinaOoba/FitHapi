# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(email: "admin@g.com" , password: "123456" )
user = User.create!(name: "FitHapi運営", account: "fithapi", introduction: "こんにちは！FitHapiで楽しい筋トレ生活を過ごしていきましょう！", email: "fithapi@test.com", password: "fitfit")
Category.create!(name: "筋トレ")
Category.create!(name: "ダイエット")
Category.create!(name: "食事")
category = Category.create!(name: "毎日の頑張り")
Article.create!(title: "はじめまして！", text: "こんにちは！FitHapi運営です。\nFitHapiでは、おすすめの筋トレメニューや毎日の頑張りを発信したり、お気に入りの筋トレメニューを保存していつでも簡単に見れたりします！\nもしサイトの改善案やご要望がありましたらこちらの記事にコメントをお願いいたします。", user_id: user.id, category_id: category.id)
base_weight = 50.0
100.times do |n|
  Weight.create!(user_id: user.id, number: base_weight - rand(-0.20..0.20), created_at: user.created_at + n.day)
end