class Restaurant < ActiveRecord::Base

  has_many :reviews, dependent: :destroy
  validates :name, length: {minimum: 3}, uniqueness: true
  belongs_to :user

  def build_review(attributes = {},user)
    review = reviews.build(attributes)
    review.user = user
    review
  end

end
