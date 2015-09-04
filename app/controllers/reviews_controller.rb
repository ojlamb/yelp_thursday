class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    p current_user.inspect
    @review = @restaurant.reviews.build({thoughts: review_params[:thoughts],
                                       rating: review_params[:rating],
                                       user_id: current_user.id})

    p @review
    if @review.save
      redirect_to restaurants_path
    else
        # redirect_to restaurants_path, alert: "You have already reviewed this restaurant"
      flash[:notice] = 'You can only leave one review'
      redirect_to restaurants_path
    end
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
