module ApplicationHelper

  def include_gritter
    css = stylesheet_link_tag 'gritter/jquery.gritter'
    js = javascript_include_tag 'gritter/jquery.gritter.min'
    css + js
  end

  def error_messages(obj)
    raw(obj.errors.full_messages.map{ |msg| content_tag(:div, content_tag(:button, raw('&times;'), class: 'close', :'data-dismiss' => 'alert') + msg, class: 'alert alert-error') }.join) if obj
  end

end
