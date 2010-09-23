module ApplicationHelper
  
  # Return a title on a per-page basis.
  def title
    base_title = "Vegtastic"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to(name, "javascript:void(0)", :class => "remove_nested_fields button")
  end
  
  def link_to_add_fields(f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render("#{association.to_s}/form", :f => builder)
    end
    return fields
  end

end
