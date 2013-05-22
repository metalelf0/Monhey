# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def currency_euro(item)
    number_to_currency(item, :unit => "&euro;", :separator => ",", :delimiter => "", :format => "%n %u")
  end
  
  def page_title_for_current_action
    if ::Rails.env == "production"
      environment_prefix = nil
    else
      environment_prefix = "[#{::Rails.env}] - "
    end
    "#{environment_prefix}#{controller.controller_name}: #{controller.action_name}"
  end
end
