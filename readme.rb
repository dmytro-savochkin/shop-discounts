# Note:
# This is a sketch.
# This code hasn't been tested manually and hasn't even been run.
#
# Obviously something won't work here but this should be enough
# to illustrate the idea. Some of the specs are not DRY enough
# but there is no time to make them better.
#
# Also I'm not adding Chain of Responsibility pattern here intentionally.
#
# So, the flow should be as follows:
# When we click "Buy Product" using the UI we send :product_id to our API
# initializing the code below. In return we should send back a new or an
# updated order with all the required info.

product = Product.find_by(params[:product_id])
order = Orders::PrepareService.new(
  customer: current_user,
  product: product,
  discounts_applier: Order::ApplyDiscountsService
).call
render json: order
