# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $("#tabs").tabs()
  $('.datepicker').datepicker(dateFormat: 'yy-mm-dd')
  # hover and click logic for todo buttons
  $(".fg-button:not(.ui-state-disabled)")
  .hover ->
    $(this).addClass("ui-state-hover")
  , ->
    $(this).removeClass("ui-state-hover")
  .mousedown ->
    $(this).parents('.fg-buttonset-single:first').find(".fg-button.ui-state-active").removeClass("ui-state-active")
    if $(this).is('.ui-state-active.fg-button-toggleable, .fg-buttonset-multi .ui-state-active')
      $(this).removeClass("ui-state-active")
    else
      $(this).addClass("ui-state-active")
  .mouseup ->
    if !$(this).is('.fg-button-toggleable, .fg-buttonset-single .fg-button,  .fg-buttonset-multi .fg-button')
      $(this).removeClass("ui-state-active")


	