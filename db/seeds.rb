Article.delete_all
puts 'Creating Articles'
5.times do |i|
  Article.create!(title: Faker::Lorem.words(rand(1..4)).join(' '), content: Faker::Lorem.paragraphs(i % 5).join(' '), category: Article::CATEGORIES.sample, status: Article::STATUSES.sample)
end

User.delete_all
puts 'Creating Users'
joe = User.create!(email: 'joe@example.com', password: 'password')
jill = User.create!(email: 'jill@example.com', password: 'password')
tom = User.create!(email: 'tom@example.com', password: 'password')

3.times do |i|
  joe.articles.create!(title: "joes_article_#{i}", content: Faker::Lorem.paragraphs(i % 5).join(' '), category: Article::CATEGORIES.sample, status: Article::STATUSES.sample)
end


jill.articles << Article.first
jill.articles <<  Article.create(title: 'Heroku Quickstart', content: 'Setting up Heroku.', category: 'software')
