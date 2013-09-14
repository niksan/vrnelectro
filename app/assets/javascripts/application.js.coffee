#= require jquery
#= require jquery_ujs
#= require ../../../vendor/assets/javascripts/bootstrap-transition
#= require ../../../vendor/assets/javascripts/bootstrap-carousel
#= require ../../../vendor/assets/javascripts/bootstrap-alert
#= require_tree ../../../vendor/assets/javascripts/fancybox
#= require_tree ../../../vendor/assets/javascripts/gritter
#= require_tree .
#= require_self

jQuery ->
  $('a.fancybox').fancybox()
  $('.field_with_errors').parent().parent().addClass('error')
  $(".alert").alert()
  $('.carousel').carousel()
  $('ul#products .img img').click ->
    window.location = $(@).parent().parent().find('.name a').attr('href')
    return false
