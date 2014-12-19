{CompositeDisposable} = require 'atom'
WelcomeUri = 'atom://welcome'

createWelcomeView = (state) ->
  WelcomeView = require './welcome-view'
  new WelcomeView(state)

atom.deserializers.add
  name: 'WelcomeView'
  deserialize: (state) -> createWelcomeView(state)

module.exports =

  config:
    showOnStartup:
      type: 'boolean'
      default: true

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.workspace.addOpener (filePath) ->
      createWelcomeView(uri: WelcomeUri) if filePath is WelcomeUri
    @subscriptions.add atom.commands.add 'atom-workspace', 'welcome:show', => @show()
    if atom.config.get('welcome.showOnStartup')
      @show()
      atom.config.set('welcome.showOnStartup', false)

    # Uncomment durring dev
    # @show()

  show: ->
    atom.workspace.open(WelcomeUri)

  deactivate: ->
    @subscriptions.dispose()
