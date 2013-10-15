$(document).ready ->
  $('#cart .cont_wrap').html("<%= escape_javascript render(:partial => 'share/cart_content', locals: {cart: @cart}) %>")
  $.gritter.add({
    title: "<%= t('cart_item.added').to_s %>",
    text: ' ',
    image: '<%= image_path('notice.png') %>',
    time: 2500
  })
