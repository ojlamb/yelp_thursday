require 'spec_helper'

describe Review, type: :model do
  
  it { is_expected.to belong_to :restaurant }

  it 'cannot have a rating greater than 5' do
    review = Review.create(rating: 6)
    expect(review).to have(1).error_on(:rating)
  end 

end