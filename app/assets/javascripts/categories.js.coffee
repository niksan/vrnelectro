jQuery ->
  $('ul#products li .img').click ->
    window.location = $(this).parent().find('.name a').attr('href')
    return false
