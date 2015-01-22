{Disposable} = require 'atom'
{$, ScrollView} = require 'atom-space-pen-views'

module.exports =
class WelcomeView extends ScrollView
  @content: ->
    @div class: 'welcome', =>
      @header class: 'welcome-header', =>
        @img class: 'welcome-logo', src: 'atom://welcome/assets/logo.png'
        @h1 class: 'welcome-title', 'A hackable text editor for the 21st Century'

      @section class: 'welcome-panel', =>

        @h2 class: 'welcome-panel-title', 'Get to know Atom!'

        @details class: 'welcome-card', =>
          @summary class: 'welcome-summary icon icon-repo', =>
            @raw 'Open a <span class="welcome-highlight">Project</span>'
          @div class: 'welcome-detail', =>
            @p '''In Atom, you can open individual files or a whole folder as a project. Let's try that! There are several ways:'''
            @ol =>
              @li =>
                @span class: 'text-highlight', 'Menu > File > Open...'
              @li =>
                @raw 'Via keyboard shortcut '
                @kbd class: 'welcome-key', 'cmd-o'
              @li =>
                @raw 'Or by dragging a folder onto the dock icon.'
            @p '''Then in the opened dialog, choose a folder you would like to open as a project. On the left you get a tree view with all the your files.'''

        @details class: 'welcome-card', =>
          @summary class: 'welcome-summary icon icon-package', =>
            @raw 'Install a <span class="welcome-highlight">Package</span>'
          @div class: 'welcome-detail', =>
            @p '''A great thing about Atom is that you can install packages which add new features and functionality fitting your needs. Let's install one.'''
            @ol =>
              @li =>
                @raw 'Open the settings, either by '
                @span class: 'text-highlight', 'Menu > Preferences'
                @raw ' or '
                @kbd class: 'welcome-key', 'cmd-,'
                @raw ' key.'
              @li =>
                @raw 'Click the "Install" menu item.'
              @li =>
                @raw 'Now you can search for new packages or check out the featured ones.'
              @li =>
                @raw 'After you installed a new package, click the "Settings" button. In the detail view you might find options to configure and adjust to your needs.'
            @p =>
              @img class: 'welcome-img', src: 'atom://welcome/assets/packages.png'

        @details class: 'welcome-card', =>
          @summary class: 'welcome-summary icon icon-paintcan', =>
            @raw 'Pick a <span class="welcome-highlight">Theme</span>'
          @div class: 'welcome-detail', =>
            @p '''Atom comes with a few preinstalled themes. Let's try a few.'''
            @ol =>
              @li =>
                @raw 'Open the settings, either by '
                @span class: 'text-highlight', 'Menu > Preferences'
                @raw ' or '
                @kbd class: 'welcome-key', 'cmd-,'
                @raw ' key.'
              @li =>
                @raw 'Click the <span class="text-highlight">Themes</span> menu item.'
              @li =>
                @raw 'Then under <span class="text-highlight">Choose a Theme</span> you can pick one from the drop down.'
            @p =>
              @img class: 'welcome-img', src: 'atom://welcome/assets/themes.png'

            @p '''You can also try out themes created by the Atom community. To install new Themes, follow the steps under "Install a Package", but switch the toggle to "themes" before searching.'''

        @details class: 'welcome-card', =>
          @summary class: 'welcome-summary icon icon-paintcan', =>
            @raw 'Customize the <span class="welcome-highlight">Styling</span>'
          @div class: 'welcome-detail', =>
            @p '''You can customize pretty much anything by adding your own CSS/LESS. As an example, let's change the cursor color.'''
            @ol =>
              @li =>
                @button class: 'btn btn-primary', 'Open your Stylesheet'
              @li =>
                @raw 'Copy&Paste the following:'
                @code =>
                  @pre 'atom-text-editor::shadow .cursor { border-color: yellow; }'
              @li =>
                @raw 'Then save! And your cursor should turn yellow.'

        @details class: 'welcome-card', =>
          @summary class: 'welcome-summary icon icon-code', =>
            @raw 'Hack on the <span class="welcome-highlight">Init Script</span>'
          @div class: 'welcome-detail', =>
            @p '''If you like to hack on how Atom works, add your own scripts.'''
            @p =>
              @button class: 'btn btn-primary', 'Open your Init Script'

        @details class: 'welcome-card', =>
          @summary class: 'welcome-summary icon icon-code', =>
            @raw 'Add a <span class="welcome-highlight">Snippet</span>'
          @div class: 'welcome-detail', =>
            @p '''Using code snippets is a great way to speed up your coding. Let's add one:'''
            @ol =>
              @li =>
                @button class: 'btn btn-primary', 'Open your Snippets'
              @li =>
                @raw 'Then uncomment the example.'

        @details class: 'welcome-card', =>
          @summary class: 'welcome-summary icon icon-keyboard', =>
            @raw 'Learn some <span class="welcome-highlight">Shortcuts</span>'
          @div class: 'welcome-detail', =>
            @p =>
              @raw 'If you only remember one thing make it '
              @kbd class: 'welcome-key', 'cmd-shift-P'
              @raw '. This keystroke toggles the command palette, which lists every Atom command. Yes, you can try it now! Press '
              @kbd class: 'welcome-key', 'cmd-shift-P'
              @raw ', type '
              @span class: 'text-highlight', 'markdown'
              @raw ' and press enter. It will trigger the '
              @span class: 'text-highlight', 'markdown-preview:show'
              @raw ' command which renders this text to HTML.'
            @p =>
              @raw 'If you ever want to see these guides again use the command palette '
              @kbd class: 'welcome-key', 'cmd-shift-P'
              @raw ' and search for '
              @span class: 'text-highlight', 'Welcome'
              @raw '.'
            @p =>
              @img class: 'welcome-img', src: 'atom://welcome/assets/shortcuts.png'


      @section class:'welcome-panel', =>
        @p 'For more help, please visit:'
        @ul =>
          @li => @raw 'The <a href="https://www.atom.io/docs">Atom docs</a> contain Guides and the API reference.'
          @li => @raw 'Discuss Atom at <a href="http://discuss.atom.io">discuss.atom.io</a>.'
          @li => @raw 'The <a href="https://github.com/atom">Atom Org</a>. This is where all GitHub created Atom packages can be found.'
        @p class: 'welcome-note', =>
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
