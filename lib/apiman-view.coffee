{View, ScrollView} = require 'atom'
TreeView = require './tree-view'

data = [{
  a: [{
    b: 'c'
    d: 'e'
  },{
    b: 'c'
    d: 'e'
  }]
}]


module.exports =
class ApimanView extends ScrollView
  @content: =>
   @div class: 'editor-colors', =>
    @subview 'tree', new TreeView(data)

  initialize: (serializeState) ->
    super
    atom.workspaceView.command "apiman:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    if @hasParent()
      @detach()
    else
      @append()

  append: ->
    pane = atom.workspaceView.getActivePane()
    pane.addItem this
    @tree.setData data


  getTitle: ->
    "Fifr view!"
