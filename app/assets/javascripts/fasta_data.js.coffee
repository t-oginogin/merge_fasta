# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.fasta_data = {}

fasta_data.merge = ->
  $(merge_form).submit()

$ ->
  # initialize
  $('#fileupload').fileupload(
    add: (e, data) ->
      $('input[name=file_dates\\[\\]]').remove()
      $.each(data.files, (index, file) ->
        $('#fileupload').append("<input type='hidden' name='file_dates[]' value='#{file.name},#{file.lastModifiedDate}'></input>")
      )
      data.submit()
    done: ->
      location.reload()
  )
