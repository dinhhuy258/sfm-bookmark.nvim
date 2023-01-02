local M = {
  opts = {},
}

local default_config = {
  mappings = {
    bookmark_mark = { "m" },
    bookmark_load = { "`" },
  },
}

function M.setup(opts)
  M.opts = default_config

  if opts == nil then
    return
  end

  if opts.mappings ~= nil and opts.mappings.bookmark_mark ~= nil then
    M.opts.mappings.bookmark_mark = opts.mappings.bookmark_mark
  end

  if opts.mappings ~= nil and opts.mappings.bookmark_load ~= nil then
    M.opts.mappings.bookmark_load = opts.mappings.bookmark_load
  end
end

return M
