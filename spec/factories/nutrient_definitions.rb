# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :nutrient_definition do |f|
  f.association :nutrient
  f.units "g"
  f.description "Carbohydrate, by difference"
end