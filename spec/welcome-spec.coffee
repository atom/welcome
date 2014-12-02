describe "Welcome", ->
  editor = null

  beforeEach ->
    spyOn(atom.workspace, 'open').andCallThrough()

    waitsForPromise ->
      atom.packages.activatePackage("welcome")

    waitsFor ->
      editor = atom.workspace.getActiveTextEditor()

  describe "when activated for the first time", ->
    it "shows the welcome buffer", ->
      expect(atom.workspace.open).toHaveBeenCalled()
      expect(editor.getText()).toMatch(/Welcome to Atom/)

  describe "when activated again", ->
    beforeEach ->
      atom.workspace.getActivePane().destroy()
      atom.packages.deactivatePackage("welcome")
      atom.workspace.open.reset()

      waitsForPromise ->
        atom.packages.activatePackage("welcome")

    it "doesn't show the welcome buffer", ->
      expect(atom.workspace.open).not.toHaveBeenCalled()

  describe "the welcome:show-welcome-buffer command", ->
    workspaceElement = null

    beforeEach ->
      workspaceElement = atom.views.getView(atom.workspace)

    it "shows the welcome buffer", ->
      atom.workspace.getActivePane().destroy()

      atom.commands.dispatch(workspaceElement, 'welcome:show-welcome-buffer')

      waitsFor ->
        editor = atom.workspace.getActiveTextEditor()

      runs ->
        expect(editor.getText()).toMatch(/Welcome to Atom/)
