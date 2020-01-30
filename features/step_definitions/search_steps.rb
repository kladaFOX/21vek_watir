require_relative '../pages/home_page.rb'

Given("a user goes to 21vek home page") do
  @home_page = site.home_page.open
end

When("a user search for {string}") do |keyword|
  @search_result_page = @home_page.enter_search_keyword(keyword)
end

When("put price filter from {int} to {int}") do |from, to|
  @search_result_page.enter_price_filter(from, to)
end

When("put {int} telephone in the cart") do |place|
  @search_result_page.put_in_the_cart(place)
end

Then("21vek should return {string}.") do |how_many|
  expect(@search_result_page.item_present_in_cart?(how_many)).to eql(true)

end
