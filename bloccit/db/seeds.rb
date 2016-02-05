require "random_data"

50.times do
  Post.create!(
    title: RandomData.random_sentence,
    body:  RandomData.random_paragraph
  )
end
posts = Post.all

1.times do
  Post.find_or_create_by(
    title: "Travel Channel",
    body: "I'll be home again soon!"
  )
end

posts = Post.all


100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

1.times do
  Comment.find_or_create_by(
    post: posts.sample,
    body: "Hello Again!"
  )
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
