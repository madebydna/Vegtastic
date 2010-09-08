# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :ingredient do |f|
  f.recipe_id 1
  f.order_of 1
  f.amount 1.5
  f.unit "MyString"
  f.name "MyString"
  f.instructions "MyString"
end
