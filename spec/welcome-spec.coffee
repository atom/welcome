describe "Welcome", ->
  editor = null

  beforeEach ->
    spyOn(atom.workspace, 'open').andCallThrough()

    waitsForPromise ->
      atom.packages.activatePackage("welcome")

    waitsFor ->
      atom.workspace.open.calls.length == 2

  describe "when activated for the first time", ->
    it "shows the welcome panes", ->
      panes = atom.workspace.getPanes()
      expect(panes).toHaveLength 2
      expect(panes[0].getItems()[0].getTitle()).toBe 'Welcome'
      expect(panes[1].getItems()[0].getTitle()).toBe 'Welcome Guide'

  describe "when activated again", ->
    beforeEach ->
      atom.workspace.getPanes().map (pane) -> pane.destroy()
      atom.packages.deactivatePackage("welcome")
      atom.workspace.open.reset()

      waitsForPromise ->
        atom.packages.activatePackage("welcome")

    it "doesn't show the welcome buffer", ->
      expect(atom.workspace.open).not.toHaveBeenCalled()

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

