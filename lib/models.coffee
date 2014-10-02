typeIsArray = Array.isArray || ( value ) -> return {}.toString.call( value ) is '[object Array]'
typeIsString = (value)-> typeof value == 'string' || value instanceof String
typeIsNumber = (value)-> value? and not isNaN(value)
createNode = (name, data)->
  console.log name
  console.log data
  if typeIsString(data) or typeIsNumber(data)
    return new Leaf({name, data})
  else
    children = []
    isArray = typeIsArray(data)
    if isArray
      for value, index in data
        children.push createNode(index, value)
    else
      for name, value of data
        children.push createNode(name, value)
    return new Node({name, children, isArray})

module.exports=
  createNode: createNode

  Node: class Node
    constructor: ({@name, @children, @isExpanded, @isArray})->

  Leaf: class Leaf
    constructor: ({@name, @data})->
