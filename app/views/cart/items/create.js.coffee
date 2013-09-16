$(document).ready ->
  $('#cart .content').html("<%= escape_javascript render(:partial => 'shared/cart_content', locals: {cart: @cart}) %>")
  $.gritter.add({
    title: "<%= t('cart_item.added').to_s %>",
    text: ' ',
    image: '<%= image_path('notice.png') %>',
    time: 2500
  })
