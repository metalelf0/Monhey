class ExpensesController < ApplicationController
 
  def index
  	if not (params[:year].nil? or params[:month].nil?)
  		@date = Date.parse(params[:year]+"/"+params[:month]+"/"+"01")
    else
      @date = Date.today
  	end
  
    @expenses = Expense.find_by_year_month(:date => @date).sort { |e1, e2| e1.date <=> e2.date }
    @hash_for_cloud = Expense.generate_hash_for_categories_cloud(@date.year, @date.month) 
  end
  
  def show
    @expense = Expense.find(params[:id])
  end

  def new
    @expense = Expense.new
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def create
    @expense = Expense.new(params[:expense])
	  if @expense.save
	    flash[:notice] = 'Expense was successfully created.'
	    redirect_to(@expense)
	  else
	    render :action => "new" 
	  end
  end
  
  def create_many
    @page_title = "Create many movements"
    @saved = ""
    for i in 1..10 do
      if !(params["elem" + i.to_s]["amount"].blank? or params["elem" + i.to_s]["description"].blank?)
        expense = Expense.new(@database_name)
        # TODO: "elem" a costante
        params["elem" + i.to_s] = handle_multiedit_params(params["elem" + i.to_s])       
        expense.attributes = expense.attributes.merge(params["elem" + i.to_s])
        expense.save(params["elem" + i.to_s])
        @saved = @saved + i.to_s
      end
    end
    flash[:notice] = @saved.to_s+" expenses correctly saved"
    redirect_to :action => :index
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update_attributes(params[:expense])
      flash[:notice] = 'Expense was successfully updated.'
      redirect_to(@expense)
    else
    	render :action => "edit" 
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to(expenses_url)
  end
  
  def handle_multiedit_params params
    params["date"] = Date.parse(
      params["date(1i)"] + "/" + # year
      pad_to_two_digits( params["date(2i)"] ) + "/" + # month
      pad_to_two_digits( params["date(3i)"] ) # day
    )
    params.delete("date(1i)")
    params.delete("date(2i)")
    params.delete("date(3i)")
    params["amount"] = params["amount"].sub("," , ".")
    params["buoni"] = params["buoni"]
    params["description"] = params["description"].capitalize
    params["ufficio"] == "true" ? params["ufficio"] = true : params["ufficio"] = false
    return params
  end

  def pad_to_two_digits string_of_numbers
    if string_of_numbers.size == 1
      string_of_numbers =  "0" + string_of_numbers
    end
    string_of_numbers
  end

end
