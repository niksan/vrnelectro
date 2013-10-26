#= require jquery
#= require jquery_ujs
#= require ../../../vendor/assets/javascripts/bootstrap-transition
#= require ../../../vendor/assets/javascripts/bootstrap-carousel
#= require ../../../vendor/assets/javascripts/bootstrap-alert
#= require_tree ../../../vendor/assets/javascripts/fancybox
#= require gritter
#= require turbolinks
#= require_tree .
#= require_self

jQuery.fn.addActiveClassOnHover = (selector) ->
  $(selector).hover(
    -> $(this).addClass('active'),
    -> $(this).removeClass('active')
  )

jQuery.fn.goToChildUrl = (selector) ->
  $(selector).click( ->
    window.location = $(this).find("a").attr("href")
    return false
  )

jQuery ->
  $('a.fancybox').fancybox()
  $('.field_with_errors').parent().parent().addClass('error')
  $(".alert").alert()
  $('.carousel').carousel()
  $('ul#products .img img').click ->
    window.location = $(@).parent().parent().find('.name a').attr('href')
    return false
  $('#cart').click ->
    window.location = $('.make_request').attr('href')
    return false
