class Week

  attr_accessor :first_day, :last_day

  def initialize date
    @first_day = date.beginning_of_week
    @last_day  = date.end_of_week
  end

  def days
    (@first_day .. @last_day)
  end

  def month
    days.collect { |d| d.month }.mode.keys.first
  end

end
