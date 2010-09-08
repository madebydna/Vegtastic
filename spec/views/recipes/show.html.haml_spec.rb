require 'spec_helper'

describe "recipes/show.html.haml" do
  before(:each) do
    @recipe = assign(:recipe, stub_model(Recipe,
      :title => "Title",
      :servings => 1,
      :description => "MyText",
      :directions => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Title".to_s)
    rendered.should contain(1.to_s)
    rendered.should contain("MyText".to_s)
    rendered.should contain("MyText".to_s)
  end
end
