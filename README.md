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
        local url = require("csgithub").search({
          includeFilename = false,
          includeExtension = true,
        })

        if url then
          require("util").open_url(url)
        end
      end,
      mode = { "n", "v" },
      desc = "Search Github",
    },
  },
},
```
