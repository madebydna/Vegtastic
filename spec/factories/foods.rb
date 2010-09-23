# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :food do |f|
  f.long_desc "Butter, salted"
  f.short_desc "BUTTER, WITH SALT"
  f.common_name ""
  f.manufacturer_name ""
end


Factory.define :other_food, :class => Food do |f|
  f.long_desc "Bread, multi-grain"
  f.short_desc ""
  f.common_name ""
  f.manufacturer_name ""
end