class ExpensesController < ApplicationController
 
  def index
  	if not (params[:year].nil? or params[:month].nil?)
  		@date = Date.parse(params[:year]+"/"+params[:month]+"/"+"01")
    else
      @date = Date.today
  	end
    @expenses = Expense.find_by_year_month(:date => @date).sort { |e1, e2| e1.date <=> e2.date } 
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
end
