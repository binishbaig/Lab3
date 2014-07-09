require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
   test "the truth" do
     assert true
   end

   test "should not save unless title has 6 or more characters" do
  	restaurant = Restaurant.new
  	assert_not restaurant.save
	end
end
