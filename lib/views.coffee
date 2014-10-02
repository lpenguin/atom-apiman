{CompositeDisposable} = require 'event-kit'
{Node, Leaf} = require './models'

buildNodeView = (node)->
  if node instanceof Leaf
    leafView = new LeafElement()
    leafView.initialize node
    return leafView
  else if node instanceof Node
    nodeView = new NodeElement
    nodeView.initialize node
    if node.isExpanded
      for child in node.children
        nodeView.addEntry buildNodeView child
    return nodeView

  return null


class NodeView extends HTMLElement
  initialize: (@node) ->
    # @subscriptions = new CompositeDisposable()
    # @subscriptions.add @node.onDidDestroy => @subscriptions.dispose()
    # @subscribeToNode()

    @classList.add('node', 'entry',  'list-nested-item')
    if @node.isExpanded
      @classList.add('expanded')
    else
      @classList.add('collapsed')

    @header = document.createElement('div')
    @appendChild(@header)
    @header.classList.add('header', 'list-item')

    @name = document.createElement('span')
    @header.appendChild(@name)
    @name.classList.add('name', 'icon')

    @entries = document.createElement('ol')
    @appendChild(@entries)
    @entries.classList.add('entries', 'list-tree')

    @name.textContent = @node.name + (if @node.isArray then '[]' else '{}')
    @name.dataset.name = @node.name
    @name.dataset.path = @node.path

  addEntry: (@entryView)->
    @entries.appendChild @entryView

  removeEntries: ->
    while @entries.firstChild
      @entries.removeChild @entries.firstChild

  toggle: ->
    if not @node.isExpanded
      @expand()
    else
      @collapse()

  expand: ->
    @node.isExpanded = true
    console.log 'expanding'
    @classList.remove('collapsed')
    @classList.add('expanded')

    for child in @node.children
      @addEntry buildNodeView child

  collapse: ->
    @node.isExpanded = false
    @classList.add('collapsed')
    @classList.remove('expanded')
    @removeEntries()

NodeElement = document.registerElement('tree-view-node', prototype: NodeView.prototype, extends: 'li')

class LeafView extends HTMLElement
  initialize: (@leaf) ->
    @classList.add('file', 'entry', 'list-item')

    @name = document.createElement('span')
    @name.classList.add('name', 'icon')
    @appendChild(@name)
    @name.textContent = "#{@leaf.name}: #{@leaf.data}"


LeafElement = document.registerElement('tree-view-leaf', prototype: LeafView.prototype, extends: 'li')

module.exports =
  NodeView: NodeElement
  LeafView: LeafElement
  buildNodeView: buildNodeView
