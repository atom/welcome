{Disposable} = require 'atom'
{$, ScrollView} = require 'atom-space-pen-views'
Reporter = require './reporter'

if process.platform is 'darwin'
  commandPaletteKeybinding = 'cmd-shift-p'
else
  commandPaletteKeybinding = 'ctrl-shift-p'

module.exports =
class GuideView extends ScrollView
  @content: ->
    @div class: 'welcome is-guide', =>
      @div class: 'welcome-container', =>
        @section class: 'welcome-panel', =>
          @h1 class: 'welcome-title', 'Get to know Atom!'

          # Project
          @details class: 'welcome-card', 'data-section': 'project', =>
            @summary class: 'welcome-summary icon icon-repo', =>
              @raw 'Open a <span class="welcome-highlight">Project</span>'
            @div class: 'welcome-detail', =>
              @p =>
                @img class: 'welcome-img', src: 'atom://welcome/assets/project.svg'
              @p '''
                  In Atom you can open individual files or a whole folder as a
                  project. Opening a folder will add a tree view to the editor
                  where you can browse all the files.
                '''
              @p =>
                @button outlet: 'projectButton', class: 'btn btn-primary', 'Open a Project'
              @p class: 'welcome-note', =>
                @raw '''
                    <strong>Next time:</strong> You can also open projects from
                    the menu, keyboard shortcut or by dragging a folder onto the
                    Atom dock icon.
                  '''

          # Packages
          @details class: 'welcome-card', 'data-section': 'packages', =>
            @summary class: 'welcome-summary icon icon-package', =>
              @raw 'Install a <span class="welcome-highlight">Package</span>'
            @div class: 'welcome-detail', =>
              @p =>
                @img class: 'welcome-img', src: 'atom://welcome/assets/package.svg'
              @p '''
                  One of the best things about Atom is the package ecosystem.
                  Installing packages adds new features and functionality you
                  can use to make the editor suit your needs. Let's install one.
                '''
              @p =>
                @button outlet: 'packagesButton', class: 'btn btn-primary', 'Open Installer'
              @p class: 'welcome-note', =>
                @raw '<strong>Next time:</strong> You can install new packages from the settings.'

          # Themes
          @details class: 'welcome-card', 'data-section': 'themes', =>
            @summary class: 'welcome-summary icon icon-paintcan', =>
              @raw 'Choose a <span class="welcome-highlight">Theme</span>'
            @div class: 'welcome-detail', =>
              @p =>
                @img class: 'welcome-img', src: 'atom://welcome/assets/theme.svg'
              @p '''Atom comes with preinstalled themes. Let's try a few.'''
              @p =>
                @button outlet: 'themesButton', class: 'btn btn-primary', 'Open the theme picker'
              @p '''
                  You can also install themes created by the Atom community. To
                  install new themes, click on "+ Install" and switch the toggle
                  to "themes".
                '''
              @p class: 'welcome-note', =>
                @raw '<strong>Next time:</strong> You can switch themes from the settings.'

          # Styling
          @details class: 'welcome-card', 'data-section': 'styling', =>
            @summary class: 'welcome-summary icon icon-paintcan', =>
              @raw 'Customize the <span class="welcome-highlight">Styling</span>'
            @div class: 'welcome-detail', =>
              @p =>
                @img class: 'welcome-img', src: 'atom://welcome/assets/code.svg'
              @p '''You can customize almost anything by adding your own CSS/LESS.'''
              @p =>
                @button outlet: 'stylingButton', class: 'btn btn-primary', 'Open your Stylesheet'
              @p '''Now uncomment some of the examples or try your own.'''
              @p class: 'welcome-note', =>
                @raw '<strong>Next time:</strong> You can open your stylesheet from Menu > Atom.'

          # Init Script
          @details class: 'welcome-card', 'data-section': 'init-script', =>
            @summary class: 'welcome-summary icon icon-code', =>
              @raw 'Hack on the <span class="welcome-highlight">Init Script</span>'
            @div class: 'welcome-detail', =>
              @p =>
                @img class: 'welcome-img', src: 'atom://welcome/assets/code.svg'
              @p '''
                  The init script is a bit of JavaScript or CoffeeScript run at
                  startup. You can use it to quickly change the behaviour of
                  Atom.
                '''
              @p =>
                @button outlet: 'initScriptButton', class: 'btn btn-primary', 'Open your Init Script'
              @p '''Uncomment some of the examples or try out your own.'''
              @p class: 'welcome-note', =>
                @raw '<strong>Next time:</strong> You can open your init script from Menu > Atom.'

          # Snippets
          @details class: 'welcome-card', 'data-section': 'snippets', =>
            @summary class: 'welcome-summary icon icon-code', =>
              @raw 'Add a <span class="welcome-highlight">Snippet</span>'
            @div class: 'welcome-detail', =>
              @p =>
                @img class: 'welcome-img', src: 'atom://welcome/assets/code.svg'
              @p '''
                  Atom snippets allow you to enter a simple prefix in the editor
                  and hit tab to expand the prefix into a larger code block with
                  templated values.
                '''
              @p =>
                @button outlet: 'snippetsButton', class: 'btn btn-primary', 'Open your Snippets'
              @p =>
                @raw '''
                    In your snippets file, type <code>snip</code> then hit
                    <code>tab</code>. The <code>snip</code> snippet will expand
                    to create a snippet!
                  '''
              @p class: 'welcome-note', =>
                @raw '<strong>Next time:</strong> You can open your snippets in Menu > Atom.'

          # Shortcuts
          @details class: 'welcome-card', 'data-section': 'shortcuts', =>
            @summary class: 'welcome-summary icon icon-keyboard', =>
              @raw 'Learn some <span class="welcome-highlight">Shortcuts</span>'
            @div class: 'welcome-detail', =>
              @p =>
                @img class: 'welcome-img', src: 'atom://welcome/assets/shortcut.svg'
              @p =>
                @raw 'If you only remember one keyboard shortcut make it '
                @kbd class: 'welcome-key', commandPaletteKeybinding
                @raw '''. This keystroke toggles the command palette, which lists every Atom command. It's a good way to learn more shortcuts. Yes, you can try it now!'''
              @p =>
                @raw 'If you want to use these guides again use the command palette '
                @kbd class: 'welcome-key', commandPaletteKeybinding
                @raw ' and search for '
                @span class: 'text-highlight', 'Welcome'
                @raw '.'

  initialize: ({openSections}) ->
    (@openSection(section) for section in openSections) if openSections?

    @projectButton.on 'click', ->
      Reporter.sendEvent('clicked-project-cta')
      atom.commands.dispatch(atom.views.getView(atom.workspace), 'application:open')
    @packagesButton.on 'click', ->
      Reporter.sendEvent('clicked-packages-cta')
      atom.workspace.open('atom://config/install', split: 'left')
    @themesButton.on 'click', ->
      Reporter.sendEvent('clicked-themes-cta')
      atom.workspace.open('atom://config/themes', split: 'left')
    @stylingButton.on 'click', ->
      Reporter.sendEvent('clicked-styling-cta')
      atom.workspace.open('atom://.atom/stylesheet', split: 'left')
    @initScriptButton.on 'click', ->
      Reporter.sendEvent('clicked-init-script-cta')
      atom.workspace.open('atom://.atom/init-script', split: 'left')
    @snippetsButton.on 'click', ->
      Reporter.sendEvent('clicked-snippets-cta')
      atom.workspace.open('atom://.atom/snippets', split: 'left')

    @on 'click', 'summary', ->
      detail = $(this).parent()
      sectionName = detail.attr('data-section')
      isOpen = !!detail.attr('open')
      action = if isOpen then 'collapse' else 'expand'
      Reporter.sendEvent("#{action}-#{sectionName}-section")

  @deserialize: (options={}) ->
    new GuideView(options)

  serialize: ->
    deserializer: @constructor.name
    openSections: @getOpenSections()
    uri: @getURI()

  getURI: -> @uri

  getTitle: -> "Welcome Guide"

  onDidChangeTitle: -> new Disposable ->
  onDidChangeModified: -> new Disposable ->

  isEqual: (other) ->
    other instanceof GuideView

  getOpenSections: ->
    openSections = @find('details[open]')
    for section in openSections
      section.getAttribute('data-section')

  openSection: (section) ->
    @find("details[data-section=\"#{section}\"]").attr('open', 'open')
