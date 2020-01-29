class HomePage
  include PageObject

  text_field(:search_box, id: "j-search")
  button(:search_box_submit, name: "sa")
  link(:cart, class: ["b-cart", "clearfix", /cr-counter/])
  text_field(:price_filter_from, name: "filter[price][from]")
  text_field(:price_filter_to, name: "filter[price][to]")
  button(:show_items, id: "j-filter__btn")
  div(:amount_of_items, class: "cr-paginator_page_list")
  div(:result_div, id: /j-result-page-/)
  span(:items_in_cart, id: 'j-basket_counter')

  def visit_21vek
    @browser.goto 'https://www.21vek.by/'
  end

  def enter_search_keyword(search_key)
    self.search_box = search_key
  end

  def search_text_present?(search_key)
    search_results.include?(search_key)
  end

  def enter_price_filter(from, to)
    self.price_filter_from = from
    self.price_filter_to = to
    show_items
  end

  def search_results_present?(amount)
    amount_of_items.include?(amount.to_s)
  end

  def put_in_the_cart(place)
    unless place % 4 == 0
      column = place / 4 + 1
      place = 4
    else
      column = place / 4
      place %= 4
    end
    xpath_string = "//*[@id='j-result-page-1']/div[#{column}]/div/ul/li[#{place}]/dl/dd/div/span[2]/form/button"
    @browser.element(:xpath, xpath_string).click

  end

  def item_present_in_cart?(how_many)
    puts items_in_cart
    wait_until{items_in_cart == how_many}
    puts items_in_cart

    items_in_cart == how_many
  end

  def close
    @browser.close
  end
end
