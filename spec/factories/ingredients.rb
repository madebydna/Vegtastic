# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :ingredient do |f|
  f.association(:recipe)
  f.order_of 1
  f.amount 1.5
  f.unit "cup"
  f.name "carrots"
  f.instructions "shredded"
end
