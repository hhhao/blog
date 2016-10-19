class Post < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: {minimum: 7}
  validates :body, presence: true

  def body_snippet
    body[0...100] + (body.length <= 100 ? '' : '...')
  end
end
