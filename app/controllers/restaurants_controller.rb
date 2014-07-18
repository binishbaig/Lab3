class RestaurantsController < ApplicationController

	before_action :authenticate_user!, except: [:index, :show]

	def new
		@restaurant = Restaurant.new
		@s3_direct_post = S3_BUCKET.presigned_post(key:
		 "uploads/#{SecureRandom.uuid}/${filename}",
		  success_action_status: 201, acl: :public_read)
	end

	def create
		@restaurant = Restaurant.new(restaurant_params)

		if @restaurant.save
			redirect_to @restaurant
		else
			render 'new'
		end
	end

	def show
		@restaurant = Restaurant.find(params[:id])
	end

	def index
		@restaurants = Restaurant.all
	end

	def edit
  		@restaurant = Restaurant.find(params[:id])
	end

	def update
		@restaurant = Restaurant.find(params[:id])

		if @restaurant.update(restaurant_params)
			redirect_to @restaurant
		else
			render 'edit'
		end
	end

	def destroy
	  @restaurant = Restaurant.find(params[:id])
	  @restaurant.destroy

	  redirect_to restaurants_path
	end

	private
  		def restaurant_params
    	params.require(:restaurant).permit(:name, :description,
    	 :address, :city, :state, :zipcode, :phone, :image, :remote_image_url)
  		end
end
