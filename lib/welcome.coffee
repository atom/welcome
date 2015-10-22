{CompositeDisposable} = require 'atom'
Reporter = null
WelcomeView = null
GuideView = null

WelcomeUri = 'atom://welcome/welcome'
GuideUri = 'atom://welcome/guide'

createWelcomeView = (state) ->
  WelcomeView ?= require './welcome-view'
  new WelcomeView(state)

createGuideView = (state) ->
  GuideView ?= require './guide-view'
  new GuideView(state)

module.exports =
  config:
    showOnStartup:
      type: 'boolean'
      default: true
      description: 'Show the Welcome package next time a new window is created. This config setting is automatically set to `false` after a new window is created and the Welcome package is shown.'

  activate: ->
    @subscriptions = new CompositeDisposable

    process.nextTick =>
      @subscriptions.add atom.deserializers.add
        name: 'WelcomeView'
        deserialize: (state) -> createWelcomeView(state)

      @subscriptions.add atom.deserializers.add
        name: 'GuideView'
        deserialize: (state) -> createGuideView(state)

      @subscriptions.add atom.workspace.addOpener (filePath) ->
        createWelcomeView(uri: WelcomeUri) if filePath is WelcomeUri
      @subscriptions.add atom.workspace.addOpener (filePath) ->
        createGuideView(uri: GuideUri) if filePath is GuideUri
      @subscriptions.add atom.commands.add 'atom-workspace', 'welcome:show', => @show()
      if atom.config.get('welcome.showOnStartup')
        @show()
        Reporter ?= require './reporter'
        Reporter.sendEvent('show-on-initial-load')
        atom.config.set('welcome.showOnStartup', false)

  show: ->
    atom.workspace.open(WelcomeUri)
    atom.workspace.open(GuideUri, split: 'right')

  consumeReporter: (reporter) ->
    Reporter ?= require './reporter'
    Reporter.setReporter(reporter)

  deactivate: ->
    @subscriptions.dispose()
