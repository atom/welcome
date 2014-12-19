{Disposable} = require 'atom'
{$, ScrollView} = require 'atom-space-pen-views'

module.exports =
class WelcomeView extends ScrollView
  @content: ->
    @div class: 'welcome', =>
      @header class: 'welcome-header', =>
        @img class: 'welcome-logo', src: 'atom://welcome/assets/logo.png'
        @h1 class: 'welcome-title', 'A hackable text editor for the 21st Century'

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
