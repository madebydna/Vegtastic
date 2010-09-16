# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :recipe do |f|
  f.title "Carrot Cake"
  f.servings 10
  f.description "Yummy, healthy and delicious"
  f.directions "Mix all ingredients and bake at 400F"
end
