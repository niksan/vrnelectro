module ApplicationHelper

  def error_messages(obj)
    raw(obj.errors.full_messages.map{ |msg| content_tag(:div, content_tag(:button, raw('&times;'), class: 'close', :'data-dismiss' => 'alert') + msg, class: 'alert alert-error') }.join) if obj
  end

end
