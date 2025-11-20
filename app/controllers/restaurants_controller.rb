class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.save
    redirect_to restaurants_path, status: :see_other
  end



  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :phone_number, :category_id)
  end
end
