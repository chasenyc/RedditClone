class Sub < ActiveRecord::Base
  validates :title, :description, :user_id, presence: true
  validate :ensure_user_exists

  belongs_to :moderator,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  has_many :posts,
    class_name: 'Post',
    foreign_key: :sub_id,
    primary_key: :id

  def ensure_user_exists
    unless User.find(user_id)
      sub.errors[:user_id] << "User id must be valid!"
    end
  end

end
