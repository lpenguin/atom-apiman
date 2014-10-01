{View, ScrollView} = require 'atom'

module.exports =
class TreeView extends ScrollView
  @content: ->
    @div =>
      @ol outlet: "list"

  initialize:() ->
    super

  setData: (@data)->

  
