path = require 'path'

module.exports =
  configDefaults:
    showOnStartup: true

  activate: ->
    atom.workspaceView.command 'welcome:show-welcome-buffer', => @show()
    if atom.config.get('welcome.showOnStartup')
      @showMetricsDialog()
      @show()
      atom.config.set('welcome.showOnStartup', false)

  showMetricsDialog: ->
    result = atom.confirm
      message: "Send Data to GitHub"
      detailedMessage: "You can help us improve Atom by allowing us send information about how it's working and how you use it.\n\nThis information is for internal use only and will not be made public.",
      buttons: ["Sure", "No Thanks"]

    atom.config.set('atom.sendUsageData', true) if result == 0

  show: ->
    atom.workspaceView.open path.join(__dirname, 'welcome.md')
