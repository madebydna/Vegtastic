# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :nutrient_definition do |f|
  f.units "g"
  f.description "Carbohydrate, by difference"
  f.tag "CHOCDF"
end
