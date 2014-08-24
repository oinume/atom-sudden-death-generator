module.exports =
  activate: ->
    atom.workspaceView.command "sudden-death:convert", => @convert()

  convert: ->
    # This assumes the active pane item is an editor
    editor = atom.workspace.activePaneItem
    selection = editor.getSelection()
    if not selection
      return
    str = selection.getText()
    if not str
      return

    str = str.replace(/(^\s+)|(\s+$)/g, "");
    #console.log("str = " + str)
    #console.log("byteLength() = %d", @byteLength(str))
    length = Math.floor(@byteLength(str) / 2);
    #converted = "＿#{@repeat('人', length + 2)}＿\n" + "＞　#{str}　＜\n" + "￣^#{@repeat('Y^', length)}￣"
    converted = """
＿#{@repeat('人', length + 2)}＿
＞　#{str}　＜
￣^#{@repeat('Y^', length)}￣
    """
    converted = converted.replace(/(^\s+)|(\s+$)/g, "");
    #console.log("--- converted ---\n%s", converted)
    selection.insertText(converted)

  byteLength: (str) ->
    len = 0
    for s in str
      c = s.charCodeAt(0)
      # console.log(" c = " + c)
      if (c >= 0x0 and c < 0x81) or (c == 0xf8f0) or (c >= 0xff61 && c < 0xffa0) or (c >= 0xf8f1 && c < 0xf8f4)
        len += 1
      else
        len += 2
    return len

  repeat: (str, n) ->
    return new Array(n + 1).join(str)
