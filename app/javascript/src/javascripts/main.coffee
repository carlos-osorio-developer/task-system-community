window.OSORIO =
  init: ->
    console.log 'Hello World'
    return 
  tasks: 
    index:
      setup: ->
        console.log 'Hello Index Page Users!'
        return
$(document).on 'turbolinks:load', ->
  OSORIO.init()