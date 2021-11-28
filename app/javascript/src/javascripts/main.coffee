window.OSORIO =
  init: ->
    console.log 'Hello World'
    return 
$(document).on 'turbolinks:load', ->
  OSORIO.init()