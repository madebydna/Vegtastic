require 'spec_helper'

describe "ingredients/edit.html.haml" do
  before(:each) do
    @ingredient = assign(:ingredient, stub_model(Ingredient,
      :new_record? => false,
      :recipe_id => 1,
      :order_of => 1,
      :amount => 1.5,
      :unit => "MyString",
      :name => "MyString",
      :instructions => "MyString"
    ))
  end

  it "renders the edit ingredient form" do
    render

    rendered.should have_selector("form", :action => ingredient_path(@ingredient), :method => "post") do |form|
      form.should have_selector("input#ingredient_recipe_id", :name => "ingredient[recipe_id]")
      form.should have_selector("input#ingredient_order_of", :name => "ingredient[order_of]")
      form.should have_selector("input#ingredient_amount", :name => "ingredient[amount]")
      form.should have_selector("input#ingredient_unit", :name => "ingredient[unit]")
      form.should have_selector("input#ingredient_name", :name => "ingredient[name]")
      form.should have_selector("input#ingredient_instructions", :name => "ingredient[instructions]")
    end
  end
end
