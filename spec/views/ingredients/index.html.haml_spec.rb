require 'spec_helper'

describe "ingredients/index.html.haml" do
  before(:each) do
    assign(:ingredients, [
      stub_model(Ingredient,
        :recipe_id => 1,
        :order_of => 1,
        :amount => 1.5,
        :unit => "Unit",
        :name => "Name",
        :instructions => "Instructions"
      ),
      stub_model(Ingredient,
        :recipe_id => 1,
        :order_of => 1,
        :amount => 1.5,
        :unit => "Unit",
        :name => "Name",
        :instructions => "Instructions"
      )
    ])
  end

  it "renders a list of ingredients" do
    render
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.5.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Unit".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Name".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Instructions".to_s, :count => 2)
  end
end
