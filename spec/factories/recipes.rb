# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :recipe do |f|
  f.title "MyString"
  f.servings 1
  f.description "MyText"
  f.directions "MyText"
end
