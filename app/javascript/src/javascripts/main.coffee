window.OSORIO =
  init: ->
    console.log 'Hello World'
    OSORIO.misc.selectizeByScope('body')
    return 
  tasks: 
    index:
      setup: ->
        console.log 'Hello Index Page Users!'
        return
  misc:
    selectizeByScope: (selector) ->
      $(selector).find('.selectize').each (i, el) ->
        $(el).selectize()
      return
$(document).on 'turbolinks:load', ->
  OSORIO.init()