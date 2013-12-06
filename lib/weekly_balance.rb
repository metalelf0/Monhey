class WeeklyBalance 

  attr_accessor :week_number, :upper_limit, :current_budget

  def initialize args
    args.each { |k,v| self.instance_variable_set(
      "@#{k}", v
    ) }
  end

end
