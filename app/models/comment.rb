class Comment < ActiveRecord::Base

  validates :user_id, :post_id, :content, presence: true
  validate  :ensure_user_exists, :ensure_post_exists

  belongs_to :author,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  belongs_to :post

  def ensure_user_exists
    unless User.find(user_id)
      comment.errors[:user_id] << "User id must be valid!"
    end
  end

  def ensure_post_exists
    unless Post.find(post_id)
      comment.errors[:post_id] << "Post id must be valid!"
    end
  end

end
