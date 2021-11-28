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
    form:
      setup: ->
        $('.participants').on 'cocoon:before-insert', (e, insertedItem, originalEvent) ->
          OSORIO.misc.selectizeByScope insertedItem          
        return
  misc:
    selectizeByScope: (selector) ->
      $(selector).find('.selectize').each (i, el) ->
        $(el).selectize()
      return
$(document).on 'turbolinks:load', ->
  OSORIO.init()