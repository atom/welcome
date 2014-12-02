path = require 'path'

module.exports =
  config:
    showOnStartup:
      type: 'boolean'
      default: true

  activate: ->
    atom.commands.add 'atom-workspace', 'welcome:show-welcome-buffer', => @show()
    if atom.config.get('welcome.showOnStartup')
      @show()
      atom.config.set('welcome.showOnStartup', false)

  show: ->
    welcomePath = path.resolve(__dirname, '..', 'docs', process.platform, 'welcome.md')
    atom.workspace.open(welcomePath)
