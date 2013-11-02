module ApplicationHelper

  def error_messages(obj)
    raw(obj.errors.full_messages.map{ |msg| content_tag(:div, content_tag(:button, raw('&times;'), class: 'close', :'data-dismiss' => 'alert') + msg, class: 'alert alert-error') }.join) if obj
  end

  def submunu(parent)
    if parent.has_children?
      content_tag :ul do
        parent.children.map do |children|
          concat(content_tag :li, link_to(children.name, category_path(children)))
        end
      end
    end
  end

end
