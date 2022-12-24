# sfm-bookmark.nvim

The sfm-bookmark extension is a plugin for the [sfm](https://github.com/dinhhuy258/sfm.nvim) plugin that adds bookmark functionality to the sfm file explorer. With sfm-bookmark, you can easily mark and navigate between files in your project.

## Demonstration

Here is a short demonstration of the sfm-bookmark extension in action:

https://user-images.githubusercontent.com/17776979/209444366-e5ac1cce-582c-4819-9f06-df31e7b63b58.mp4

## Installation

To install the `sfm-bookmark` extension, you will need to have the [sfm](https://github.com/dinhhuy258/sfm.nvim) plugin installed. You can then install the extension using your preferred plugin manager. For example, using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
{
  "dinhhuy258/sfm.nvim",
  requires = {
    { "dinhhuy258/sfm-bookmark.nvim" },
  },
  config = function()
    require("sfm").setup {}
    require("sfm").load_extention "sfm-bookmark" -- load extension after initializing the sfm plugin
  end
}
```

## Configuration

The `sfm-bookmark` extension does **not** provide any additional configuration options beyond those provided by the `sfm` plugin.

## Usage

Use `m` + `key` to mark the current entry, and \` + `key` to navigate to the marked entry.
