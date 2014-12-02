describe "Welcome", ->
  openFileTimeout = 200

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("welcome")
    waits(openFileTimeout)

  describe "when activated for the first time", ->
    it "shows the welcome buffer", ->
      editor = atom.workspace.getPaneItems()[0]
      expect(editor.getText()).toMatch(/Welcome to Atom/)

  describe "when activated again", ->
    beforeEach ->
      atom.workspace.getActivePane().destroy()
      atom.packages.deactivatePackage("welcome")

      waitsForPromise ->
        atom.packages.activatePackage("welcome")
      waits(openFileTimeout)

    it "doesn't show the welcome buffer", ->
      expect(atom.workspace.getPaneItems().length).toBe(0)

  describe "the welcome:show-welcome-buffer command", ->
    workspaceElement = null

    beforeEach ->
      workspaceElement = atom.views.getView(atom.workspace)

    it "shows the welcome buffer", ->
      atom.workspace.getActivePane().destroy()

      atom.commands.dispatch(workspaceElement, 'welcome:show-welcome-buffer')
      waits(openFileTimeout)

      runs ->
        editor = atom.workspace.getPaneItems()[0]
        expect(editor.getText()).toMatch(/Welcome to Atom/)
