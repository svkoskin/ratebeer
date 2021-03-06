class BeerClubsController < ApplicationController
  before_action :ensure_that_signed_in, :except => [:index, :show]
  before_action :ensure_that_admin, :only => [:destroy]

  before_action :set_beer_club, only: [:show, :edit, :update, :destroy]

  # GET /beer_clubs
  def index
    @beer_clubs = BeerClub.all
  end

  # GET /beer_clubs/1
  def show
    @membership = Membership.new
    @membership.beer_club = @beer_club

    @confirmed_users = User.joins(memberships: :beer_club).where('memberships.confirmed' => true, 'beer_clubs.id' => @beer_club.id)
    
    if current_user and not Membership.find_by_user_id_and_beer_club_id_and_confirmed(current_user.id, @beer_club.id, true).nil?
      @current_user_is_a_member = true
    else
      @current_user_is_a_member = false
    end

    if @current_user_is_a_member
      @pending_memberships = Membership.where(beer_club: @beer_club, confirmed: false).all
    end
  end

  # GET /beer_clubs/new
  def new
    @beer_club = BeerClub.new
  end

  # GET /beer_clubs/1/edit
  def edit
  end

  # POST /beer_clubs
  def create
    @beer_club = BeerClub.new(beer_club_params)   

    if @beer_club.save

      # Make the creating user a member of the bclub
      @membership = Membership.new(beer_club: @beer_club, user: current_user, confirmed: true)

      if @membership.save
        redirect_to @beer_club, notice: 'Beer club was successfully created.'
      else
        render action: 'new'
      end
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /beer_clubs/1
  def update
    if @beer_club.update(beer_club_params)
      redirect_to @beer_club, notice: 'Beer club was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /beer_clubs/1
  def destroy
    @beer_club.destroy
    redirect_to beer_clubs_url, notice: 'Beer club was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beer_club
      @beer_club = BeerClub.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def beer_club_params
      params.require(:beer_club).permit(:name, :founded, :city)
    end
end
