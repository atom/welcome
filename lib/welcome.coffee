path = require 'path'

module.exports =
  activate: ->
    console.log path.join(__dirname, 'welcome.md')
    atom.rootView.open path.join(__dirname, 'welcome.md')
