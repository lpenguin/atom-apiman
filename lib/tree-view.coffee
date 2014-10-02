{View, ScrollView} = require 'atom'

{NodeView, buildNodeView} = require './views'
{Node, Leaf, createNode} = require './models'

module.exports =
class TreeView extends ScrollView
  @content: ->
    @div =>
      @ol outlet: "list", class: 'tree-view full-menu list-tree has-collapsable-children focusable-panel'

  initialize:() ->
    super
    @on 'click', '.entry', (e) =>
      @entryClicked(e) unless e.shiftKey or e.metaKey or e.ctrlKey

  entryClicked: (event)->
    console.log event

    switch event.originalEvent?.detail ? 1
      when 1
        console.log "entryClicked 1"
      when 2
        console.log "entryClicked 2"

    elem = event.currentTarget
    if elem.node?
      elem.toggle()

    false


  setData: (@data)->
    console.log 'setdata'
    node = createNode('root', @data)
    nodeView = buildNodeView(node)
    @list.element.appendChild(nodeView)
