class BrowserContainer
  include PageObject

  def initialize(browser)
    @browser = browser
    @browser.window.maximize
  end
end

  class Site_21vek < BrowserContainer
    def home_page
      @home_page = HomePage.new(@browser)
    end

    def search_result_page
      @search_result_page = SearchResultPage.new(@browser)
    end

    def close
      @browser.close
    end
  end


  class HomePage < BrowserContainer
    URL = 'https://www.21vek.by/'

    def open
      @browser.goto URL
      self
    end

    def enter_search_keyword(search_key)
      search_field.set search_key
      search_field_submit
      next_page = SearchResultPage.new @browser
      next_page
    end

    private
    def search_field
      @browser.text_field(id: "j-search")
    end

    def search_field_submit
      @browser.button(name: "sa").click
    end
  end


  class SearchResultPage < BrowserContainer
    URL = 'https://www.21vek.by/search/'

    def enter_price_filter(from, to)
      price_filter_from.set from
      price_filter_to.set to
      show_items
    end

    def put_in_the_cart(place)
      column = (place - 1) % 4 + 1
      row = (place - 1) / 4 + 1
      buy_item_button(column, row)
      puts items_in_cart
      Watir::Wait.until{items_in_cart != "нет товаров"}
      puts items_in_cart
    end

    def item_present_in_cart?(how_many)
      items_in_cart == how_many
    end

    private

    def price_filter_from
      @browser.text_field(name: "filter[price][from]")
    end

    def price_filter_to
      @browser.text_field(name: "filter[price][to]")
    end

    def show_items
      @browser.button(id: "j-filter__btn").click
    end

    def buy_item_button(column, row)
      xpath_string = "//*[@id='j-result-page-1']/div[#{row}]/div/ul/li[#{column}]/dl/dd/div/span[2]/form/button"
      @browser.element(:xpath, xpath_string).click
    end

    def items_in_cart
      @browser.span(id: 'j-basket_counter').text
    end
  end
