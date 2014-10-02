{CompositeDisposable} = require 'event-kit'

class NodeView extends HTMLElement
  initialize: (@node) ->
    # @subscriptions = new CompositeDisposable()
    # @subscriptions.add @node.onDidDestroy => @subscriptions.dispose()
    # @subscribeToNode()

    @classList.add('node', 'entry',  'list-nested-item',  'collapsed')

    @header = document.createElement('div')
    @appendChild(@header)
    @header.classList.add('header', 'list-item')

    @name = document.createElement('span')
    @header.appendChild(@name)
    @name.classList.add('name', 'icon')

    @entries = document.createElement('ol')
    @appendChild(@entries)
    @entries.classList.add('entries', 'list-tree')

    # @name.classList.add('icon-file-directory')
    @name.textContent = @node.name
    @name.dataset.name = @node.name
    @name.dataset.path = @node.path

    # if @node.isRoot
    #   @classList.add('project-root')
    # else
    #   @subscriptions.add @node.onDidStatusChange => @updateStatus()
    #   @updateStatus()
    #
    # @expand() if @node.isExpanded

  # updateStatus: ->
  #   @classList.remove('status-ignored', 'status-modified', 'status-added')
  #   @classList.add("status-#{@node.status}") if @node.status?
  #
  # emitDirectoryModifiedEvent: ->
  #   if @isExpanded
  #     event = new CustomEvent('tree-view:directory-modified', bubbles: true)
  #     @dispatchEvent(event)
  #
  # subscribeToNode: ->
  #   @subscriptions.add @node.onDidAddEntries (addedEntries) =>
  #     return unless @isExpanded
  #
  #     numberOfEntries = @entries.children.length
  #
  #     for entry in addedEntries
  #       view = @createViewForEntry(entry)
  #
  #       insertionIndex = entry.indexInParentDirectory
  #       if insertionIndex < numberOfEntries
  #         @entries.insertBefore(view, @entries.children[insertionIndex])
  #       else
  #         @entries.appendChild(view)
  #
  #       numberOfEntries++
  #
  #     @emitDirectoryModifiedEvent()
  #
  #   @subscriptions.add @node.onDidRemoveEntries =>
  #     @emitDirectoryModifiedEvent() if @isExpanded
  #
  # getPath: ->
  #   @node.path
  #
  # createViewForEntry: (entry) ->
  #   if entry instanceof Directory
  #     view = new DirectoryElement()
  #   else
  #     view = new FileView()
  #   view.initialize(entry)
  #
  #   subscription = @node.onDidRemoveEntries (removedEntries) ->
  #     for removedName, removedEntry of removedEntries when entry is removedEntry
  #       view.remove()
  #       subscription.dispose()
  #       break
  #   @subscriptions.add(subscription)
  #
  #   view
  #
  # reload: ->
  #   @node.reload() if @isExpanded
  #
  # toggleExpansion: (isRecursive=false) ->
  #   if @isExpanded then @collapse(isRecursive) else @expand(isRecursive)
  #
  # expand: (isRecursive=false) ->
  #   unless @isExpanded
  #     @isExpanded = true
  #     @classList.add('expanded')
  #     @classList.remove('collapsed')
  #     @node.expand()
  #
  #   if isRecursive
  #     for entry in @entries.children when entry instanceof DirectoryView
  #       entry.expand(true)
  #
  #   false
  #
  # collapse: (isRecursive=false) ->
  #   @isExpanded = false
  #
  #   if isRecursive
  #     for entry in @entries.children when entry.isExpanded
  #       entry.collapse(true)
  #
  #   @classList.remove('expanded')
  #   @classList.add('collapsed')
  #   @node.collapse()
  #   @entries.innerHTML = ''

NodeElement = document.registerElement('tree-view-node', prototype: NodeView.prototype, extends: 'li')
module.exports = NodeElement
