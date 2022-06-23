# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(email: "admin@g.com" , password: "123456" )
User.create!(name: "FitHapi運営", account: "fithapi", introduction: "こんにちは！FitHapiで楽しい筋トレ生活を過ごしていきましょう！", email: "fithapi@test.com", password: "fitfit")
Category.create!(name: "筋トレ")
Category.create!(name: "ダイエット")
Category.create!(name: "食事")
Category.create!(name: "毎日の頑張り")
Article.create!(title: "はじめまして！", text: "こんにちは！FitHapi運営です。FitHapiでは、おすすめの筋トレメニューや毎日の頑張りを発信したり、お気に入りの筋トレメニューを保存していつでも簡単に見れたりします！もしサイトの改善案やご要望がありましたらこちらの記事にコメントをお願いいたします。", user_id: 1, category_id: 4)