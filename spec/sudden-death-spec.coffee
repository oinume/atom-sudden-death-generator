{WorkspaceView} = require 'atom'
AsciiArt = require '../lib/sudden-death'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "SuddenDeath", ->
  promise = null
  beforeEach ->
    atom.workspaceView = new WorkspaceView()
    atom.workspace = atom.workspaceView.model
    promise = atom.packages.activatePackage('sudden-death')
    waitsForPromise ->
      atom.workspace.open()

  it "convert", ->
    atom.workspaceView.trigger 'sudden-death:convert'
    waitsForPromise ->
      promise
