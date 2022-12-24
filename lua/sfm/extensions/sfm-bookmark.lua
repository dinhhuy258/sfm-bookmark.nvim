local event = require "sfm.event"
local sfm_actions = require "sfm.actions"

local M = {
  sfm_explorer = nil,
  marks = {},
}

local function get_mark_key()
  return vim.fn.nr2char(vim.fn.getchar())
end

function M.set_mark()
  local mark_key = get_mark_key()
  if mark_key == nil or mark_key == "" then
    return
  end

  M.marks[mark_key] = M.sfm_explorer:get_current_entry()
end

function M.load_mark()
  local mark_key = get_mark_key()
  if mark_key == nil or mark_key == "" or not rawget(M.marks, mark_key) then
    return
  end

  local entry = M.marks[mark_key]
  sfm_actions.focus_file(entry.path)
end

function M.setup(sfm_explorer)
  M.sfm_explorer = sfm_explorer

  M.sfm_explorer:subscribe(event.ExplorerOpen, function(payload)
    local bufnr = payload["bufnr"]
    local options = {
      noremap = true,
      silent = true,
      expr = false,
    }

    vim.api.nvim_buf_set_keymap(
      bufnr,
      "n",
      "m",
      "<CMD>lua require('sfm.extensions.sfm-bookmark').set_mark()<CR>",
      options
    )
    vim.api.nvim_buf_set_keymap(
      bufnr,
      "n",
      "`",
      "<CMD>lua require('sfm.extensions.sfm-bookmark').load_mark()<CR>",
      options
    )
  end)
end

return M
