{CompositeDisposable} = require 'atom'
Reporter = null
WelcomeView = null
GuideView = null
ConsentView = null

WelcomeUri = 'atom://welcome/welcome'
GuideUri = 'atom://welcome/guide'
ConsentUri = 'atom://welcome/consent'

createWelcomeView = (state) ->
  WelcomeView ?= require './welcome-view'
  new WelcomeView(state)

createGuideView = (state) ->
  GuideView ?= require './guide-view'
  new GuideView(state)

createConsentView = (state) ->
  ConsentView ?= require './consent-view'
  new ConsentView(state)

module.exports =
  activate: ->
    @subscriptions = new CompositeDisposable

    process.nextTick =>
      @subscriptions.add atom.deserializers.add
        name: 'WelcomeView'
        deserialize: (state) -> createWelcomeView(state)

      @subscriptions.add atom.deserializers.add
        name: 'GuideView'
        deserialize: (state) -> createGuideView(state)

      @subscriptions.add atom.deserializers.add
        name: 'ConsentView'
        deserialize: (state) -> createConsentView(state)

      @subscriptions.add atom.workspace.addOpener (filePath) ->
        createWelcomeView(uri: WelcomeUri) if filePath is WelcomeUri
      @subscriptions.add atom.workspace.addOpener (filePath) ->
        createGuideView(uri: GuideUri) if filePath is GuideUri
      @subscriptions.add atom.workspace.addOpener (filePath) ->
        createConsentView(uri: ConsentUri) if filePath is ConsentUri
      @subscriptions.add atom.commands.add 'atom-workspace', 'welcome:show', => @show()

      if atom.config.get('core.telemetryConsent') is 'undecided'
        atom.workspace.open(ConsentUri)

      if atom.config.get('welcome.showOnStartup')
        @show()
        Reporter ?= require './reporter'
        Reporter.sendEvent('show-on-initial-load')

  show: ->
    atom.workspace.open(WelcomeUri)
    atom.workspace.open(GuideUri, split: 'right')

  consumeReporter: (reporter) ->
    Reporter ?= require './reporter'
    Reporter.setReporter(reporter)

  deactivate: ->
    @subscriptions.dispose()
