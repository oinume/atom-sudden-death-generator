{WorkspaceView} = require 'atom'
AtomSuddenDeath = require '../lib/sudden-death'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "AtomSuddenDeath", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('sudden-death')

  describe "when the sudden-death:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.sudden-death')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'sudden-death:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.sudden-death')).toExist()
        atom.workspaceView.trigger 'sudden-death:toggle'
        expect(atom.workspaceView.find('.sudden-death')).not.toExist()
