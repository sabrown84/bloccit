class AddTopicToSponsoredPosts < ActiveRecord::Migration
  def change
    add_column :sponsored_posts, :sponsored_posts_id, :integer
    add_index :sponsored_posts, :sponsored_posts_id
  end
end
