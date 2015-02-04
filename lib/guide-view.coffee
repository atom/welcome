{Disposable} = require 'atom'
{$, ScrollView} = require 'atom-space-pen-views'

module.exports =
class GuideView extends ScrollView
  @content: ->
    @div class: 'welcome is-guide', =>

      @section class:'welcome-panel', =>
        @h2 class: 'welcome-panel-title', 'Get to know Atom!'

        # Project
        @details class: 'welcome-card', =>
          @summary class: 'welcome-summary icon icon-repo', =>
            @raw 'Open a <span class="welcome-highlight">Project</span>'
          @div class: 'welcome-detail', =>
            @p =>
              @img class: 'welcome-img', src: 'atom://welcome/assets/project.svg'
            @p '''In Atom you can open individual files or a whole folder as a project. It will add a tree view on the left where you can browse all the files.'''
            @p =>
              @button outlet: 'projectButton', class: 'btn btn-primary', 'Open a Project'
            @p class: 'welcome-note', =>
               @raw '<strong>Next time:</strong> You can also open projects from the menu, keyboard shortcut or dragging a folder onto the Atom dock icon.'

        # Packages
        @details class: 'welcome-card', =>
          @summary class: 'welcome-summary icon icon-package', =>
            @raw 'Install a <span class="welcome-highlight">Package</span>'
          @div class: 'welcome-detail', =>
            @p =>
              @img class: 'welcome-img', src: 'atom://welcome/assets/package.svg'
            @p '''A great thing about Atom is that you can install packages which add new features and functionality fitting your needs. Let's install one.'''
            @p =>
              @button outlet: 'packagesButton', class: 'btn btn-primary', 'Open Installer'
            @p class: 'welcome-note', =>
               @raw '<strong>Next time:</strong> You can install new packages in the settings.'

        # Themes
        @details class: 'welcome-card', =>
          @summary class: 'welcome-summary icon icon-paintcan', =>
            @raw 'Choose a <span class="welcome-highlight">Theme</span>'
          @div class: 'welcome-detail', =>
            @p =>
              @img class: 'welcome-img', src: 'atom://welcome/assets/theme.svg'
            @p '''Atom comes with preinstalled themes. Let's try a few.'''
            @p =>
              @button outlet: 'themesButton', class: 'btn btn-primary', 'Open the theme picker'
            @p '''You can also try out themes created by the Atom community. To install new themes, click on "+ Install" and switch the toggle to "themes".'''
            @p class: 'welcome-note', =>
               @raw '<strong>Next time:</strong> You can switch themes in the settings.'

        # Styling
        @details class: 'welcome-card', =>
          @summary class: 'welcome-summary icon icon-paintcan', =>
            @raw 'Customize the <span class="welcome-highlight">Styling</span>'
          @div class: 'welcome-detail', =>
            @p =>
              @img class: 'welcome-img', src: 'atom://welcome/assets/code.svg'
            @p '''You can customize pretty much anything by adding your own CSS/LESS.'''
            @p =>
              @button outlet: 'stylingButton', class: 'btn btn-primary', 'Open your Styleshet'
            @p '''Now uncomment some of the examples or try your own.'''
            @p class: 'welcome-note', =>
               @raw '<strong>Next time:</strong> You can open your styleshet in Menu > Atom.'

        # Init Script
        @details class: 'welcome-card', =>
          @summary class: 'welcome-summary icon icon-code', =>
            @raw 'Hack on the <span class="welcome-highlight">Init Script</span>'
          @div class: 'welcome-detail', =>
            @p =>
              @img class: 'welcome-img', src: 'atom://welcome/assets/code.svg'
            @p '''If you like to hack on how Atom works, you can do so by adding init scripts.'''
            @p =>
              @button outlet: 'initScriptButton', class: 'btn btn-primary', 'Open your Init Script'
            @p '''Now uncomment some of the examples or try your own.'''
            @p class: 'welcome-note', =>
               @raw '<strong>Next time:</strong> You can open your init script in Menu > Atom.'

        # Snippets
        @details class: 'welcome-card', =>
          @summary class: 'welcome-summary icon icon-code', =>
            @raw 'Add a <span class="welcome-highlight">Snippet</span>'
          @div class: 'welcome-detail', =>
            @p =>
              @img class: 'welcome-img', src: 'atom://welcome/assets/code.svg'
            @p '''Using code snippets is a great way to speed up your coding. Let's add some.'''
            @p =>
              @button outlet: 'snippetsButton', class: 'btn btn-primary', 'Open your Snippets'
            @p '''Now uncomment some of the examples or try your own.'''
            @p class: 'welcome-note', =>
               @raw '<strong>Next time:</strong> You can open your snippets in Menu > Atom.'

        # Shortcuts
        @details class: 'welcome-card', =>
          @summary class: 'welcome-summary icon icon-keyboard', =>
            @raw 'Learn some <span class="welcome-highlight">Shortcuts</span>'
          @div class: 'welcome-detail', =>
            @p =>
              @img class: 'welcome-img', src: 'atom://welcome/assets/shortcut.svg'
            @p =>
              @raw 'If you only remember one keyboard shortcut make it '
              @kbd class: 'welcome-key', 'cmd-shift-P'
              @raw '''. This keystroke toggles the command palette, which lists every Atom command. It's a good way to learn more shortcuts. Yes, you can try it now!'''
            @p =>
              @raw 'ps. If you ever want to see these guides again use the command palette '
              @kbd class: 'welcome-key', 'cmd-shift-P'
              @raw ' and search for '
              @span class: 'text-highlight', 'Welcome'
              @raw '.'


  initialize: ->
    @projectButton.on 'click', =>
      atom.commands.dispatch(atom.views.getView(atom.workspace), 'application:open')
    @packagesButton.on 'click', =>
      atom.commands.dispatch(atom.views.getView(atom.workspace), 'settings-view:install-packages-and-themes')
    @themesButton.on 'click', =>
      atom.commands.dispatch(atom.views.getView(atom.workspace), 'settings-view:change-themes')
    @stylingButton.on 'click', =>
      atom.commands.dispatch(atom.views.getView(atom.workspace), 'application:open-your-stylesheet')
    @initScriptButton.on 'click', =>
      atom.commands.dispatch(atom.views.getView(atom.workspace), 'application:open-your-init-script')
    @snippetsButton.on 'click', =>
      atom.commands.dispatch(atom.views.getView(atom.workspace), 'application:open-your-snippets')


  @deserialize: (options={}) ->
    new GuideView(options)

  serialize: ->
    deserializer: @constructor.name
    collapsedSections: @getCollapsedSections()
    uri: @getUri()

  getUri: -> @uri

  getTitle: -> "Guide"

  onDidChangeTitle: -> new Disposable ->
  onDidChangeModified: -> new Disposable ->

  isEqual: (other) ->
    other instanceof GuideView
