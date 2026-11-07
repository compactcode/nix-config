local mod = "SUPER"

-- focus the given application on a workspace, launching it there if missing
local function focus_or_exec(ws, class, cmd)
  local win = hl.get_windows({ workspace = ws, class = class })[1]
  if win then
    hl.dispatch(hl.dsp.focus({ window = win }))
  else
    hl.exec_cmd(cmd, { workspace = tostring(ws) })
  end
end

-- focus the project terminal on a workspace, picking a project if missing
local function focus_or_project(ws)
  local win = hl.get_windows({ workspace = ws, class = "kitty" })[1]
  if win then
    hl.dispatch(hl.dsp.focus({ window = win }))
  else
    hl.dispatch(hl.dsp.focus({ workspace = ws }))
    hl.exec_cmd("~/.local/share/rofi/project.sh")
  end
end

-- applications tied to particular workspaces
hl.bind(mod .. " + A", hl.dsp.exec_cmd("~/.local/share/rofi/project.sh"))
hl.bind(mod .. " + E", function() focus_or_project(3) end)
hl.bind(mod .. " + N", function() focus_or_exec(1, "firefox", "firefox") end)
hl.bind(mod .. " + O", function() focus_or_exec(4, "obsidian", "obsidian") end)
hl.bind(mod .. " + R", function() focus_or_exec(5, "Slack", "slack") end)
hl.bind(mod .. " + S", function() focus_or_project(2) end)

-- applications
hl.bind(mod .. " + I", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mod .. " + B", hl.dsp.exec_cmd("~/.local/share/rofi/bookmark.sh"))
hl.bind(mod .. " + T", hl.dsp.exec_cmd("kitty"))
hl.bind(mod .. " + F", hl.dsp.exec_cmd("kitty yazi"))
hl.bind(mod .. " + P", hl.dsp.exec_cmd("grimblast --notify edit area"))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

-- focused window actions
hl.bind(mod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen())

-- open scratchpad
hl.bind(mod .. " + C", hl.dsp.workspace.toggle_special("scratchpad"))

-- open workspaces and move windows
hl.bind(mod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))
for i = 1, 9 do
  hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- move windows with left mouse, resize with right mouse
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- auto create floating terminal on scratchpad
hl.on("workspace.created", function(ws)
  if ws.name == "special:scratchpad" and ws.is_empty then
    hl.exec_cmd("kitty", { workspace = "special:scratchpad" })
  end
end)
