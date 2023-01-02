local config = require "sfm.extensions.sfm-bookmark.config"
local event = require "sfm.event"
local sfm_actions = require "sfm.actions"

local M = {
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

  M.marks[mark_key] = sfm_actions.get_current_entry()
end

function M.load_mark()
  local mark_key = get_mark_key()
  if mark_key == nil or mark_key == "" or not rawget(M.marks, mark_key) then
    return
  end

  local entry = M.marks[mark_key]
  sfm_actions.focus_file(entry.path)
end

function M.setup(sfm_explorer, opts)
  config.setup(opts)

  sfm_explorer:subscribe(event.ExplorerOpen, function(payload)
    local bufnr = payload["bufnr"]
    local options = {
      noremap = true,
      silent = true,
      expr = false,
    }

    -- mark
    if type(config.opts.mappings.bookmark_mark) == "table" then
      for _, key in pairs(config.opts.mappings.bookmark_mark) do
        vim.api.nvim_buf_set_keymap(
          bufnr,
          "n",
          key,
          "<CMD>lua require('sfm.extensions.sfm-bookmark').set_mark()<CR>",
          options
        )
      end
    else
      vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        config.opts.mappings.bookmark_mark,
        "<CMD>lua require('sfm.extensions.sfm-bookmark').set_mark()<CR>",
        options
      )
    end

    -- load
    if type(config.opts.mappings.bookmark_load) == "table" then
      for _, key in pairs(config.opts.mappings.bookmark_load) do
        vim.api.nvim_buf_set_keymap(
          bufnr,
          "n",
          key,
          "<CMD>lua require('sfm.extensions.sfm-bookmark').load_mark()<CR>",
          options
        )
      end
    else
      vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        config.opts.mappings.bookmark_load,
        "<CMD>lua require('sfm.extensions.sfm-bookmark').load_mark()<CR>",
        options
      )
    end
  end)
end

return M
