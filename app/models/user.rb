class User < ApplicationRecord

  has_many :reviews
  has_many :upvotes, through: :reviews
  has_secure_password

  validates :name, :email, presence: true
  validates_uniqueness_of :email
  validates_length_of :password, minimum: 12, too_short: "Password should be at least 12 characters"

  def owns_review?(review)
    review.user == self
  end

  def owns_restaurant_review(restaurant)
    Review.where(["user_id = ? AND restaurant_id = ?", self.id, restaurant.id])
  end

end
