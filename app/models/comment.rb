class Comment < ActiveRecord::Base
  belongs_to :posts
  belongs_to :users
  belongs_to :topics

  validates :body, length: { minimum: 5, presence: true}
  validates :user, presence: true
end
