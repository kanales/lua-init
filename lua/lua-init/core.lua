local _os_name
local _os_arch

local core = {}

local function guess_os()
  local raw_os_name, raw_os_arch

  if jit and jit.os and jit.arch then
    raw_os_name = jit.os
    raw_os_arch = jit.arch
  else
    error "luaJIT support is needed"
  end
  _os_name, _os_arch = "unknown", "unknown"

  if raw_os_arch:match "windows" then
    _os_name = "Windows"
  elseif raw_os_name:match "linux" then
    _os_name = "Linux"
  elseif raw_os_name:match "mac" then
    _os_name = "Mac"
  elseif raw_os_name:match "darwin" then
    _os_name = "Mac"
  elseif raw_os_name:match "^mingw" then
    _os_name = "Windows"
  elseif raw_os_name:match "^cygwin" then
    _os_name = "Windows"
  elseif raw_os_name:match "bsd$" then
    _os_name = "BSD"
  elseif raw_os_name:match "SunOS" then
    _os_name = "Solaris"
  end

  if raw_os_arch:match "^x86$" then
    _os_arch = "x86"
  elseif raw_os_arch:match "i[%d]86" then
    _os_arch = "x86"
  elseif raw_os_arch:match "amd64" then
    _os_arch = "x86_64"
  elseif raw_os_arch:match "x86_64" then
    _os_arch = "x86_64"
  elseif raw_os_arch:match "Power Macintosh" then
    _os_arch = "powerpc"
  elseif raw_os_arch:match "^arm" then
    _os_arch = "arm"
  elseif raw_os_arch:match "^mips" then
    _os_arch = "mips"
  end
  return _os_arch, _os_name
end

function core.os()
  if _os_name == nil then
    guess_os()
  end
  return _os_name
end

function core.arch()
  if _os_arch == nil then
    guess_os()
  end
  return _os_arch
end

return core
