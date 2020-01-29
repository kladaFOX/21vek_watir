require_relative '../pages/home_page.rb'

Given("a user goes to 21vek home page") do
  @home_page = HomePage.new(@browser)
  @home_page.visit_21vek
end

When("a user search for {string}") do |keyword|
  @home_page.search_box_element.wait_until(&:present?)
  @home_page.enter_search_keyword(keyword)
  @home_page.search_box_submit
end

When("put price filter from {int} to {int}") do |from, to|
  @home_page.enter_price_filter(from, to)
end

When("put {int} telephone in the cart") do |place|
  @home_page.put_in_the_cart(place)
end

Then("21vek should return {string}.") do |how_many|
  expect(@home_page.item_present_in_cart?(how_many)).to eql(true)

end
