A simple plugin to simplify searching for code on [Github Code Search](https://cs.github.com).

In `normal` mode, searches for the word under the cursor.

In `visual` mode, searches for the selected text.

### Demo

https://user-images.githubusercontent.com/33713262/226383032-113b4db8-27a3-4b8f-aa36-c0765b2cc903.mp4

### Install

```lua
-- Install with Lazy
{
  "thenbe/csgithub.nvim",
  keys = {
    {
      "<leader>feg",
      function()
        local csgithub = require("csgithub")

        local url = csgithub.search({
          includeFilename = false,
          includeExtension = true,
          betaSearch = false, -- if you have opted in to the beta search on github, toggle this to true
        })

        csgithub.open(url)
      end,
      mode = { "n", "v" },
      desc = "Search Github",
    },
  },
}
```
