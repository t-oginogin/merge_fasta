# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.fasta_data = {}

fasta_data.merge = ->
  $(merge_form).submit()

$ ->
  # initialize
  $('#fileupload').fileupload(
    done: ->
      location.reload()
  )

  clipboard = new Clipboard('.copy-button')
