{$} = require 'atom-space-pen-views'
Reporter = require '../lib/reporter'

describe "Welcome", ->
  editor = null

  beforeEach ->
    spyOn(atom.workspace, 'open').andCallThrough()

  describe "when `core.telemetryConsent` is 'undecided'", ->
    beforeEach ->
      atom.config.set('core.telemetryConsent', 'undecided')

      waitsForPromise ->
        atom.packages.activatePackage("welcome")

      waitsFor ->
        atom.workspace.open.calls.length is 3

    it "opens the telemetry consent pane and the welcome panes", ->
      panes = atom.workspace.getPanes()
      expect(panes).toHaveLength 2
      expect(panes[0].getItems()[0].getTitle()).toBe 'Telemetry Consent'
      expect(panes[0].getItems()[1].getTitle()).toBe 'Welcome'
      expect(panes[1].getItems()[0].getTitle()).toBe 'Welcome Guide'

  describe "when `core.telemetryConsent` is not `undecided`", ->
    beforeEach ->
      atom.config.set('core.telemetryConsent', 'no')

      waitsForPromise ->
        atom.packages.activatePackage("welcome")

      waitsFor ->
        atom.workspace.open.calls.length is 2

    describe "when activated for the first time", ->
      it "shows the welcome panes", ->
        panes = atom.workspace.getPanes()
        expect(panes).toHaveLength 2
        expect(panes[0].getItems()[0].getTitle()).toBe 'Welcome'
        expect(panes[1].getItems()[0].getTitle()).toBe 'Welcome Guide'

    describe "the welcome:show command", ->
      workspaceElement = null

      beforeEach ->
        workspaceElement = atom.views.getView(atom.workspace)

      it "shows the welcome buffer", ->
        atom.workspace.getPanes().map (pane) -> pane.destroy()
        expect(atom.workspace.getActivePaneItem()).toBeUndefined()
        atom.commands.dispatch(workspaceElement, 'welcome:show')

        waitsFor ->
          atom.workspace.getActivePaneItem()

        runs ->
          panes = atom.workspace.getPanes()
          expect(panes).toHaveLength 2
          expect(panes[0].getItems()[0].getTitle()).toBe 'Welcome'

    describe "deserializing the pane items", ->
      [panes, guideView, welcomeView] = []
      beforeEach ->
        panes = atom.workspace.getPanes()
        welcomeView = panes[0].getItems()[0]
        guideView = panes[1].getItems()[0]

      describe "when GuideView is deserialized", ->
        it "deserializes with no state", ->
          {deserializer, uri} = guideView.serialize()
          newGuideView = atom.deserializers.deserialize({deserializer, uri})

        it "remembers open sections", ->
          guideView.element.querySelector("details[data-section=\"snippets\"]").setAttribute('open', 'open')
          guideView.element.querySelector("details[data-section=\"init-script\"]").setAttribute('open', 'open')

          serialized = guideView.serialize()

          expect(serialized.openSections).toEqual ['init-script', 'snippets']

          newGuideView = atom.deserializers.deserialize(serialized)

          expect(newGuideView.element.querySelector("details[data-section=\"packages\"]").hasAttribute('open')).toBe(false)
          expect(newGuideView.element.querySelector("details[data-section=\"snippets\"]").hasAttribute('open')).toBe(true)
          expect(newGuideView.element.querySelector("details[data-section=\"init-script\"]").hasAttribute('open')).toBe(true)

    describe "reporting events", ->
      [panes, guideView, welcomeView] = []
      beforeEach ->
        panes = atom.workspace.getPanes()
        welcomeView = panes[0].getItems()[0]
        guideView = panes[1].getItems()[0]

        spyOn(Reporter, 'sendEvent')

      describe "GuideView events", ->
        it "captures expand and collapse events", ->
          expect(Reporter.sendEvent).not.toHaveBeenCalled()

          guideView.element.querySelector("details[data-section=\"packages\"] summary").click()
          expect(Reporter.sendEvent).toHaveBeenCalledWith('expand-packages-section')
          expect(Reporter.sendEvent).not.toHaveBeenCalledWith('collapse-packages-section')

          guideView.element.querySelector("details[data-section=\"packages\"]").setAttribute('open', 'open')
          guideView.element.querySelector("details[data-section=\"packages\"] summary").click()
          expect(Reporter.sendEvent).toHaveBeenCalledWith('collapse-packages-section')

        it "captures button events", ->
          spyOn(atom.commands, 'dispatch')
          for detailElement in guideView.element.querySelector('details')
            sectionName = detailElement.dataset.section
            eventName = "clicked-#{sectionName}-cta"
            if primaryButton = detailElement.querySelector('.btn-primary')
              expect(Reporter.sendEvent).not.toHaveBeenCalledWith(eventName)
              primaryButton.click()
              expect(Reporter.sendEvent).toHaveBeenCalledWith(eventName)

    describe "when the reporter changes", ->
      it "sends all queued events", ->
        reporter1 = sendEvent: jasmine.createSpy('sendEvent')
        reporter2 = sendEvent: jasmine.createSpy('sendEvent')

        Reporter.sendEvent('foo', 'bar', 'baz')
        Reporter.sendEvent('foo2', 'bar2', 'baz2')
        Reporter.setReporter(reporter1)

        expect(reporter1.sendEvent).toHaveBeenCalledWith 'welcome-v1', 'foo', 'bar', 'baz'
        expect(reporter1.sendEvent).toHaveBeenCalledWith 'welcome-v1', 'foo2', 'bar2', 'baz2'

        Reporter.setReporter(reporter2)
        expect(reporter2.sendEvent.callCount).toBe 0
