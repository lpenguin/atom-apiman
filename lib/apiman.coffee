ApimanView = require './apiman-view'
TreeView = require './tree-view'

module.exports =
  apimanView: null

  activate: (state) ->
    @apimanView = new ApimanView(false)

  deactivate: ->
    @apimanView.destroy()
