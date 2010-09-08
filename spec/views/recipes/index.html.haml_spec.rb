require 'spec_helper'

describe "recipes/index.html.haml" do
  before(:each) do
    assign(:recipes, [
      stub_model(Recipe,
        :title => "Title",
        :servings => 1,
        :description => "MyText",
        :directions => "MyText"
      ),
      stub_model(Recipe,
        :title => "Title",
        :servings => 1,
        :description => "MyText",
        :directions => "MyText"
      )
    ])
  end

  it "renders a list of recipes" do
    render
    rendered.should have_selector("tr>td", :content => "Title".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
