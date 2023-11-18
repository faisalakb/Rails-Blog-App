class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  attribute :title, :string
  attribute :text, :text
  attribute :comments_counter, :integer, default: 0
  attribute :likes_counter, :integer, default: 0
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  after_save :update_post_counter
  after_destroy :update_post_counter

  def update_post_counter
    author.update(posts_counter: author.posts.count)
  end

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
