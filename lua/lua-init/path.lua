local core = require "lua-init.core"
local path = {}

path.sep = core.os() == "Windows" and "\\" or "/"

function path.join(...)
  local tbl = {}
  if select("#", ...) == 1 then
    local arg = select(1, ...)
    if type(arg) == "table" then
      tbl = arg
    else
      return tostring(arg)
    end
  end
  return table.concat(tbl, path.sep)
end

return path
