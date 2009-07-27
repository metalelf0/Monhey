# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def currency_euro (item)
      number_to_currency (item, :unit => "&euro;", :separator => ",", :delimiter => "", :format => "%n %u")
  end


end
