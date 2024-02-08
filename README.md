A simple plugin to simplify searching for code on [Github Code Search](https://cs.github.com).

In `normal` mode, searches for the word under the cursor.

In `visual` mode, searches for the selected text.

### Demo

https://user-images.githubusercontent.com/33713262/226383032-113b4db8-27a3-4b8f-aa36-c0765b2cc903.mp4

### Install

```lua
{
  'thenbe/csgithub.nvim',
  keys = {
    {
      '<leader>fege',
      function()
        local csgithub = require('csgithub')
        local url = csgithub.search({
          includeFilename = false,
          includeExtension = true,
        })
        csgithub.open(url)
      end,
      mode = { 'v', 'n' },
      desc = 'Search Github (extension)',
    },
    {
      '<leader>fegf',
      function()
        local csgithub = require('csgithub')
        local url = csgithub.search({
          includeFilename = true,
          includeExtension = true,
        })
        csgithub.open(url)
      end,
      mode = { 'v', 'n' },
      desc = 'Search Github (filename)',
    },
  },
}
```

### Keys

This plugin does not set any keymaps, so you'll need to set some on your own. The snippet above is how I have mine set up, and includes two keymaps:

1. A keymap that searches in files that have the same extension (e.g. `*.nix`, `*.lua`).
1. A keymap for searching in files that have the exact same filename. This is useful when the file lacks intellisense and you can't quite remember the exact syntax (e.g. `.gitconfig`, `.npmrc`, `flake.nix`, `kitty.conf`).
