class RemoveSubIdFromPosts < ActiveRecord::Migration
  def change
    Post.all.each do |post|
      PostSub.create!(post_id: post.id, sub_id: post.sub_id)
    end

    remove_column :posts, :sub_id
  end
end
