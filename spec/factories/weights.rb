# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :weight do |f|
  f.association :food
  f.amount 1
  f.measure_desc "cup"
  f.gm_weight 227
end
