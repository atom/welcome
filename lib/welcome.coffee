path = require 'path'

module.exports =
  configDefaults:
    showWelcomeBuffer: true

  activate: ->
    return unless atom.config.get('welcom.showWelcomeBuffer')
    atom.rootView.open path.join(__dirname, 'welcome.md')
    atom.config.set('welcom.showWelcomeBuffer', false)
