path = require 'path'

module.exports =
  configDefaults:
    showOnStartup: true

  activate: ->
    atom.workspaceView.command 'welcome:show-welcome-buffer', => @show()
    if atom.config.get('welcome.showOnStartup')
      @show()
      atom.config.set('welcome.showOnStartup', false)

  show: ->
    welcomePath = path.resolve(__dirname, '..', 'docs', process.platform, 'welcome.md')
    atom.workspaceView.open welcomePath
