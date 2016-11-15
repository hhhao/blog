class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments, -> {order(created_at: :desc)}, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :fans, through: :favourites, source: :user
  validates :title, presence: true, uniqueness: true, length: {minimum: 7}
  validates :body, presence: true

  def body_snippet
    body[0...100] + (body.length <= 100 ? '' : '...')
  end
end
