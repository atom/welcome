{Disposable} = require 'atom'
{$, ScrollView} = require 'atom-space-pen-views'

module.exports =
class WelcomeView extends ScrollView
  @content: ->
    @div class: 'welcome', =>
      @div class: 'welcome-container', =>
        @header class: 'welcome-header', =>
          @img class: 'welcome-logo', src: 'atom://welcome/assets/logo.png'
          @h1 class: 'welcome-title', 'A hackable text editor for the 21st Century'

        @section class:'welcome-panel', =>
          @p 'There is a lot more to discover. For help, please visit:'
          @ul =>
            @li => @raw 'The <a href="https://www.atom.io/docs">Atom docs</a> contain Guides and the API reference.'
            @li => @raw 'Discuss Atom at <a href="http://discuss.atom.io">discuss.atom.io</a>.'
            @li => @raw 'The <a href="https://github.com/atom">Atom Org</a>. This is where all GitHub created Atom packages can be found.'
          @p class: 'welcome-note welcome-metrics', =>
             @raw '<strong>Note:</strong> To help us improve Atom, we anonymously track usage metrics, such as launch time, screen size, used version etc. See the
             <a href="https://github.com/atom/metrics">atom/metrics</a> package for details and for instructions on how to disable it.'

        @footer class:'welcome-footer', =>
          @raw '<a href="https://atom.io/">atom.io</a> <span class="text-subtle">×</span> <a class="icon icon-octoface" href="https://github.com/"></a>'


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
