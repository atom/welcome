{Disposable} = require 'atom'
{$, ScrollView} = require 'atom-space-pen-views'

module.exports =
class WelcomeView extends ScrollView
  @content: ->
    @div class: 'welcome', =>
      @header class: 'welcome-header', =>
        @img class: 'welcome-logo', src: 'atom://welcome/assets/logo.png'
        @h1 class: 'welcome-title', 'A hackable text editor for the 21st Century'

      @div class: 'welcome-panel', =>
        @details class: 'welcome-card', =>
          @summary class: 'welcome-summary icon icon-package', =>
            @raw 'Install a <span class="welcome-highlight">Package</span>'
          @p class: 'welcome-detail', 'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.'

        @details class: 'welcome-card', =>
          @summary class: 'welcome-summary icon icon-paintcan', =>
            @raw 'Pick a <span class="welcome-highlight">Theme</span>'
          @p class: 'welcome-detail',
            '''Atom comes with a few preinstalled themes. Let's try a few.'''
          @p class: 'welcome-detail',
            'Open the settings, either by Menu > Preferences or [cmd-,] key. Click the "Themes" menu item. And under "Choose a Theme" you can pick one from the drop down.'

        @details class: 'welcome-card', =>
          @summary class: 'welcome-summary icon icon-keyboard', =>
            @raw 'Learn some <span class="welcome-highlight">Shortcuts</span>'
          @p class: 'welcome-detail', 'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.'


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
