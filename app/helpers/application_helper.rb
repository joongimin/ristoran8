module ApplicationHelper
  def link_to_add_fields(name, f, association)
    association_reflection = f.object.class.reflect_on_association(association)
    new_object = association_reflection.klass.new
    fields = f.fields_for(association, new_object, :child_index => "@new_#{association}@") do |b|
      render(association.to_s.singularize + "_fields", :f => b)
    end
    content_tag(:a, name, :onclick => h("add_fields(this, #{association_reflection.collection?}, \"#{association}\", \"#{escape_javascript(fields)}\")"), :class => "link_add_fields").html_safe
  end

  def link_to_remove_fields(name, f)
    (f.hidden_field(:_destroy) + content_tag(:a, name, :onclick => "remove_fields(this)", :class => "link_remove_fields")).html_safe
  end
end
