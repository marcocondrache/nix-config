local home = os.getenv("HOME")
local roots = { "Personal", "Work" }

local function list_projects()
  local items = {}
  for _, root in ipairs(roots) do
    local r = rex.exec({ "find", home .. "/" .. root, "-mindepth", "1", "-maxdepth", "1", "-type", "d", "-not", "-name", ".*" })
    if r and r.ok then
      local dirs = {}
      for dir in r.stdout:gmatch("[^\n]+") do
        table.insert(dirs, dir)
      end
      table.sort(dirs)
      for _, dir in ipairs(dirs) do
        table.insert(items, {
          id = dir,
          title = dir:match("[^/]+$"),
          subtitle = root,
          icon = "folder",
        })
      end
    end
  end
  return items
end

rex.action({
  name = "project",
  title = "Open Project",
  description = "Pick a project from ~/Personal or ~/Work and open it in its own session",
  category = "Projects",
  keywords = "switch repo cd",
  args = { dir = "string?" },
  run = function(ctx, args)
    local dir = args.dir
    if not dir then
      local reason
      dir, reason = rex.ui.pick({ title = "Open project", placeholder = "Filter projects", items = list_projects() })
      if not dir then
        if reason == "cancelled" then return end
        error("project picker: " .. tostring(reason))
      end
    end

    local name = dir:match("[^/]+$")

    local list, err = rex.call("session.list")
    if not list then error(err) end

    local session_id
    for _, s in ipairs(list.sessions or {}) do
      if s.label == name then
        session_id = s.session_id
        break
      end
    end

    if not session_id then
      local created, cerr = rex.call("session.create", {
        label = name,
        initial_windows = {
          {
            window_label = name,
            layout = rex.layout.block({
              flavor = "com.superlogical.terminal.shell",
              options = { cwd = dir },
            }),
          },
        },
      })
      if not created then error(cerr) end
      session_id = created.session_id
    end

    if ctx.client_id then
      rex.client.queue("session.select", { session_id = session_id })
    end
    return { session_id = session_id, label = name }
  end,
})

rex.bind("cmd+o", "project")
