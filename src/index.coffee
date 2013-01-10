coffeescript = require 'coffee-script-redux'

module.exports = class CoffeeScriptReduxCompiler
  brunchPlugin: yes
  type: 'javascript'
  extension: 'coffee'

  constructor: (@config) ->
    return

  compile: (data, path, callback) ->
    try
      csAst = coffeescript.parse data,
        raw: yes
      jsAst = coffeescript.compile csAst
      result = coffeescript.js jsAst
      # Hack to remove generated function and comment
      result = result.split("\n")
      result.pop()
      result.shift()
      result.shift()
      result = result.join("\n")
    catch err
      error = err
    finally
      callback error, result
