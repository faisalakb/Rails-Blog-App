class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :comments, dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy
  has_many :posts, foreign_key: :author_id, dependent: :destroy

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :role, inclusion: { in: %w[admin user], message: "%{value} is not a valid role" }

  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end
  
  def admin?
    role == 'admin'
  end
end
