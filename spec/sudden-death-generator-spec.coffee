{WorkspaceView} = require 'atom'
AsciiArt = require '../lib/sudden-death-generator'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "SuddenDeath", ->
  promise = null
  beforeEach ->
    atom.workspaceView = new WorkspaceView()
    atom.workspace = atom.workspaceView.model
    promise = atom.packages.activatePackage('sudden-death-generator')
    waitsForPromise ->
      atom.workspace.open()

  it "generate", ->
    atom.workspaceView.trigger 'sudden-death-generator:generate'
    waitsForPromise ->
      promise
