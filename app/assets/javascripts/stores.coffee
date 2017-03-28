# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener "turbolinks:load", ->
  $('.entry>a').click (e)->
    e.preventDefault()
    $(this).closest('.entry').find('form').trigger('submit')
