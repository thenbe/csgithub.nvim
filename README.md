A simple plugin to simplify searching for code on [Github Code Search](https://cs.github.com).

In `normal` mode, searches for the word under the cursor.

In `visual` mode, searches for the selected text.

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
