require 'watir'
require 'page-object'
require_relative '../pages/home_page.rb'

module SiteHelper
  def site
    @site ||= (
      Site_21vek.new(Watir::Browser.new(:chrome))
    )
  end
end

World(SiteHelper)
