class ModelHelper

  def ModelHelper.build_categories_option_list_from_array(arr)
   arr2 = []
   arr.each_with_index do |el, index|
    if index == 0
     arr2 << "<option selected=\"selected\">" + el + "</option>"
    else
     arr2 << "<option>"+el+"</option>"
    end
   end
   return arr2
  end

  def ModelHelper.days_in_month_of(year, month)
    return (Date.new(year.to_i, month.to_i + 1, 1) -1).day
  end


end