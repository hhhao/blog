class User < ApplicationRecord
  has_secure_password

  before_validation :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false},
            format: VALID_EMAIL_REGEX
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_many :favourites, dependent: :destroy
  has_many :fav_posts, through: :favourites, source: :post
  
  private

  def downcase_email
    self.email.downcase! if email.present?
  end

end
