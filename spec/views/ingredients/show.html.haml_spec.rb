require 'spec_helper'

describe "ingredients/show.html.haml" do
  before(:each) do
    @ingredient = assign(:ingredient, stub_model(Ingredient,
      :recipe_id => 1,
      :order_of => 1,
      :amount => 1.5,
      :unit => "Unit",
      :name => "Name",
      :instructions => "Instructions"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(1.5.to_s)
    rendered.should contain("Unit".to_s)
    rendered.should contain("Name".to_s)
    rendered.should contain("Instructions".to_s)
  end
end
