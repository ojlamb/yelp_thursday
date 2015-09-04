class Review < ActiveRecord::Base
  validates :user, uniqueness: { scope: :restaurant, message: "Has reviewed this restaurant already" }
  belongs_to :restaurant
  belongs_to :users
  validates :rating, inclusion: (1..5)

end
