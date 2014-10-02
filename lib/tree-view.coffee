{View, ScrollView} = require 'atom'

NodeView = require './node-view'
{Node, Leaf, createNode} = require './models'

module.exports =
class TreeView extends ScrollView
  @content: ->
    @div =>
      @ol outlet: "list", class: 'tree-view full-menu list-tree has-collapsable-children focusable-panel'

  initialize:() ->
    super

  setData: (@data)->
    node = createNode('foo', @data)
    console.log node
    nodeView = new NodeView()
    nodeView.initialize(node)
    @list.element.appendChild(nodeView)
