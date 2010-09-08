require 'spec_helper'

describe "recipes/edit.html.haml" do
  before(:each) do
    @recipe = assign(:recipe, stub_model(Recipe,
      :new_record? => false,
      :title => "MyString",
      :servings => 1,
      :description => "MyText",
      :directions => "MyText"
    ))
  end

  it "renders the edit recipe form" do
    render

    rendered.should have_selector("form", :action => recipe_path(@recipe), :method => "post") do |form|
      form.should have_selector("input#recipe_title", :name => "recipe[title]")
      form.should have_selector("input#recipe_servings", :name => "recipe[servings]")
      form.should have_selector("textarea#recipe_description", :name => "recipe[description]")
      form.should have_selector("textarea#recipe_directions", :name => "recipe[directions]")
    end
  end
end
