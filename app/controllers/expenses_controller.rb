class ExpensesController < ApplicationController
 
  def index
  	@date = build_date_from_params(params)
  	if params[:category_name].blank?
      @expenses = Expense.find_by_year_month(:date => @date).sort { |e1, e2| e1.date <=> e2.date } 
    else
      @expenses = Expense.find_by_year_month_and_category(@date, params[:category_name])
    end
    @hash_for_cloud = Expense.generate_hash_for_categories_cloud(@date) 
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

  private
  
  def build_date_from_params params
    if not (params[:year].nil? or params[:month].nil?)
  		@date = Date.new(params[:year].to_i, params[:month].to_i, 1)
    else
      @date = Date.today
  	end
  end

end
