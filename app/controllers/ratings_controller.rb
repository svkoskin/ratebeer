class RatingsController < ApplicationController
  def index
    @recent_ratings = Rating.recent
    @best_breweries = Brewery.top 3
    @best_beers = Beer.top 3
    @most_active_users = User.top 3
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    if current_user.nil?
      redirect_to signin_path
    else
      @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

      if @rating.save
        current_user.ratings << @rating
        redirect_to user_path current_user
      else
        @beers = Beer.all 
        render :new
      end
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end
