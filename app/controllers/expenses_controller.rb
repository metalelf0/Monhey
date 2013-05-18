class ExpensesController < ApplicationController
 
  def index
  	@date = build_date_from_params(params)
    @categories = Category.all(:select => :name).map {|category| category.name }.compact.sort
  	if params[:category_name].blank?
      @expenses = ExpenseRepository.new.find_by_year_month(:date => @date).sort { |e1, e2| e1.date <=> e2.date }.select {|e| e.amount < 0}
      @incomes =  ExpenseRepository.new.find_by_year_month(:date => @date).sort { |e1, e2| e1.date <=> e2.date }.select {|e| e.amount >= 0}
    else
      @expenses = ExpenseRepository.new.find_by_year_month_and_category(@date, params[:category_name]).sort { |e1, e2| e1.date <=> e2.date }.select {|e| e.amount < 0}
      @incomes =  ExpenseRepository.new.find_by_year_month_and_category(@date, params[:category_name]).sort { |e1, e2| e1.date <=> e2.date }.select {|e| e.amount >= 0}
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
    @categories = Category.all(:select => :name).map {|category| category.name }.compact.sort
  end

  def create
    @expense = Expense.new(params[:expense])
	  if @expense.save
	    flash[:notice] = 'Expense was successfully created.'
      redirect_to expenses_url
	  else
	    render :action => "new" 
	  end
  end
  
  def create_many
    @page_title = "Create many movements"
    for i in 1..10 do
      if !(params["elem" + i.to_s]["amount"].blank? || params["elem" + i.to_s]["description"].blank?)
        expense = Expense.new
        # TODO: "elem" a costante
        params["elem" + i.to_s] = handle_multiedit_params(params["elem" + i.to_s])       
        expense.attributes = expense.attributes.merge(params["elem" + i.to_s])
        expense.save()
      end
    end
    flash[:notice] = "expenses correctly saved"
    redirect_to expenses_url
  end

  def update
    @expense = Expense.find(params[:id])
    @expense.category = Category.find_or_create_by_name(params[:category_name])
    params.delete("category_name")
    if @expense.update_attributes(params[:expense])
      flash[:notice] = 'Expense was successfully updated.'
      redirect_to expenses_url
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
    params["description"] = params["description"].capitalize
    params["category_id"] = Category.find_or_create_by_name(params[:category_name]).id
    params.delete("category_name")
    return params
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
