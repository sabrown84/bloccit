require "random_data"

15.times do
  Topic.create!(
    sponsored_post: sponsored_posts.sample,
    name:           RandomData.random_sentence,
    description:    RandomData.random_paragraph
  )
end
topics = Topic.all

50.times do
  Post.create!(
    topic: topics.sample,
    title: RandomData.random_sentence,
    body:  RandomData.random_paragraph
  )
end
posts = Post.all

25.times do
  SponsoredPost.create!(
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph,
    price:  Random.rand(10)
  )
end

sponsored_post = SponsoredPost.all

100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

100.times do
  Advertisement.create!(
    title: RandomData.random_sentence,
    copy:  RandomData.random_paragraph,
    price: Random.rand(10)
  )
end

100.times do
  Question.create!(
    title:    RandomData.random_sentence,
    body:     RandomData.random_paragraph,
    resolved: false
  )
end

puts "Seed finished"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{SponsoredPost.count} sponsored posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advetisements created"
puts "#{Question.count} questions created"
