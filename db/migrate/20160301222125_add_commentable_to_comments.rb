class AddCommentableToComments < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true
    end
  end
end
