class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    # p @restaurant
    p current_user.inspect
    # @review = @restaurant.build_review review_params, current_user
    @review = @restaurant.reviews.build({thoughts: review_params[:thoughts],
                                       rating: review_params[:rating],
                                       uid: current_user.id})


    # @review = @restaurant.reviews.build(review_params)
    p @review
    if @review.save?
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        # redirect_to restaurants_path, alert: "You have already reviewed this restaurant"
      flash[:alert] = 'You can only leave one review'
      redirect_to restaurants_path 
       render :new
      end
    end
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
