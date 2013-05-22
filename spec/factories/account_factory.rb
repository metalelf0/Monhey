Factory.define :account do |a|
  a.name "An account"
  a.association :user
end