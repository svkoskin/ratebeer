class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :set_beer_clubs, only: [:new, :edit]

  # GET /memberships
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  def create
    @membership = Membership.new(membership_params)
    @membership.user_id = current_user.id

    if @membership.save
      redirect_to current_user, notice: 'Membership was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /memberships/1
  def update
    if @membership.update(membership_params)
      redirect_to @membership, notice: 'Membership was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /memberships/1
  def destroy
    @membership.destroy
    redirect_to memberships_url, notice: 'Membership was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    def set_beer_clubs
      @beer_clubs = BeerClub.all
    end

    # Only allow a trusted parameter "white list" through.
    def membership_params
      params.require(:membership).permit(:beer_club_id, :user_id)
    end
end
