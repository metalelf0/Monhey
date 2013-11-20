Factory.define :expense do |e|
  e.description "Third" 
  e.amount -10
  e.include_in_budget true
  e.date { Date.new(2009,3,1) } 
  e.association :category
  e.association :user
end
