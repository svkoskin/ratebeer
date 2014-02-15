class RatingsController < ApplicationController
  def index
    @ratings = Rating.all

    respond_to do |format|
      format.html { }
      format.json { render json: @ratings }
    end
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
