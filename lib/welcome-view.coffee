{Disposable} = require 'atom'
{$, ScrollView} = require 'atom-space-pen-views'

module.exports =
class WelcomeView extends ScrollView
  @content: ->
    @div class: 'welcome', =>
      @h1 'Welcome to Atom'

  @deserialize: (options={}) ->
    new WelcomeView(options)

  serialize: ->
    deserializer: @constructor.name
    collapsedSections: @getCollapsedSections()
    uri: @getUri()

  getUri: -> @uri

  getTitle: -> "Welcome"

  onDidChangeTitle: -> new Disposable ->
  onDidChangeModified: -> new Disposable ->

  isEqual: (other) ->
    other instanceof WelcomeView
