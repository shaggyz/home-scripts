# NeoWiki

A small, opinionated Neovim plugin that covers the handful of [VimWiki](https://github.com/vimwiki/vimwiki) features I actually use, written in Lua.

> **Heads up — this is a personal plugin.**
> I wrote it for my own workflow: daily TODO files in Markdown plus a few named knowledge bases I jump between. It's intentionally narrow. If you're looking for a full VimWiki replacement, this isn't it. If a thin layer that does *just* daily diary + markdown navigation + scoped pickers sounds right, read on.

## Status

Work in progress. The configuration surface may still shift before a tagged release. Use it from a git pin or local path until then.

## Scope

What NeoWiki **does**:

- Manage one diary wiki with date-stamped Markdown files (`YYYY/MM/YYYY-MM-DD.md`).
- Register additional named knowledge bases at arbitrary paths.
- Drive `find_files` / `live_grep` against any wiki via your existing picker plugin (telescope, fzf-lua, snacks.picker, mini.pick, or the `vim.ui` fallback).
- A small set of Markdown helpers I use daily: link insert/follow, TOC generation, checkbox toggle, URL highlighting.

What NeoWiki **does not do** (and probably never will, on purpose):

- VimWiki's wiki-link syntax (`[[Foo]]`). Only standard CommonMark `[label](target)` is supported.
- Multiple markup languages. Markdown only.
- HTML export, table formatting, tag indices, backlinks, diary templates, or any of the larger VimWiki feature surface.
- Inter-wiki links (`work:notes/foo.md`). Maybe later — see TODOs in `CLAUDE.md`.

If those gaps matter to you, stay with VimWiki.

## Installation

Zero plugin-manager metadata required — just point the manager at the repo (or a local path).

**lazy.nvim**
```lua
{
    "shaggyz/neowiki",       -- once published
    -- or: dir = "~/path/to/neowiki",
    config = function()
        require("neowiki").setup({
            wikis = {
                diary = { path = "~/Notes", diary = true },
            },
        })
    end,
}
```

**packer.nvim**
```lua
use({
    "shaggyz/neowiki",
    config = function() require("neowiki").setup({ ... }) end,
})
```

**vim-plug** (then call `setup()` from your `init.lua`)
```vim
Plug 'shaggyz/neowiki'
```

No `plugin/` file is shipped — you must call `setup()`. This keeps the plugin lazy-load friendly.

## Configuration

All keys are optional. Defaults shown below.

```lua
require("neowiki").setup({
    -- Named knowledge bases. Each entry: { path = <dir>, diary = <bool> }
    -- At most one entry may set diary = true. The diary wiki is what
    -- :WikiToday / :WikiYesterday / :WikiTomorrow operate on.
    wikis = nil,

    -- Name used when commands/API are invoked without an explicit wiki name.
    -- Defaults to the diary wiki; falls back to the first registered entry.
    default_wiki = nil,

    -- Picker backend. "auto" walks: telescope -> fzf-lua -> snacks -> mini -> vim_ui.
    -- Force a specific one with "telescope" | "fzf-lua" | "snacks" | "mini" | "vim_ui".
    picker = "auto",

    -- Legacy single-wiki shim. When `wikis` is not provided, NeoWiki
    -- synthesizes a single wiki at this path with diary = true.
    wiki_directory = "~/Notes",

    -- Create missing wiki directories on setup.
    auto_create_wiki_directory = true,

    -- New daily files reuse the previous day's content (minus the date header
    -- and any completed `- [x]` tasks).
    reuse_previous_day = true,

    -- When true, "yesterday" and "tomorrow" skip Sat/Sun and the
    -- reuse_previous_day template pulls from the last workday.
    -- Concretely: on Monday, "yesterday" = Friday.
    weekdays_only = false,

    -- Highlight https?:// and mailto: URLs in markdown buffers.
    format_links = true,
    links_color = "#6cb6eb",

    -- Verbose logging during setup.
    debug = false,
})
```

A multi-wiki example:

```lua
require("neowiki").setup({
    wikis = {
        diary    = { path = "~/Notes",                       diary = true },
        personal = { path = "~/Nextcloud/VimWiki/personal" },
        work     = { path = "~/Nextcloud/VimWiki/work" },
    },
    default_wiki = "diary",
    weekdays_only = true,
})
```

## Features

Each command and helper, one section apiece.

### Daily diary

Files live at `<diary_path>/YYYY/MM/YYYY-MM-DD.md`. The folder structure is created on demand.

- **`:WikiToday`** — Open today's file. Created if absent.
- **`:WikiYesterday`** — Open yesterday's file. With `weekdays_only = true`, opens the previous workday instead (so Mondays land on Friday).
- **`:WikiTomorrow`** — Mirror of `WikiYesterday`.
- **`:WikiCurrentMonth`** — Open the current month's folder (e.g. `~/Notes/2026/05/`) for browsing.

When `reuse_previous_day = true`, a freshly created daily file is seeded with the previous day's content (minus the old `# TODO` header and minus any `- [x]` completed tasks). New header `# TODO <date>` is written automatically. With `weekdays_only` enabled, "previous day" follows the same workday-aware rule.

### Named knowledge bases

Any directory registered under `wikis` becomes searchable independently of the diary.

- **`:WikiFind [name]`** — Find files in the named wiki (or `default_wiki` if omitted). Routed through your picker.
- **`:WikiGrep [name]`** — Live grep within the wiki.
- **`:WikiOpen [name]`** — `:edit` the wiki root directory (useful with `oil.nvim`, `netrw`, etc.).
- **`:WikiSelect [action]`** — `vim.ui.select` a wiki, then run an action on it. `action` ∈ `find_files` (default) | `live_grep` | `open`.

All `[name]` arguments tab-complete from the registered wiki names.

### Markdown helpers

- **`:WikiCreateLink`** — Wraps the word under the cursor (or the visual selection) as `[text](url)`. If the system clipboard contains a `https?://` URL, it's inserted as the target automatically. Cursor lands on the closing `)` so pressing `i` types inside the parens.
- **`:WikiCreateIndex`** — Inserts a Table of Contents at the top of the buffer. Walks all `# … ######` headings via tree-sitter and emits a nested bullet list of `[heading](#slug)` links. The block is wrapped in `<!-- neowiki:index:start -->` / `<!-- neowiki:index:end -->` sentinels, so re-running the command **replaces** the previous index rather than stacking new ones.
- **`:WikiFollowLink`** — Follows the `[label](target)` link under the cursor. Also bound to `gf` in Markdown buffers via a FileType autocmd. Targets:
  - `#anchor` — jump to a heading with a matching slug.
  - `https://…` / `http://…` / `mailto:…` — dispatch to `vim.ui.open` (Nvim 0.10+) or `open`/`xdg-open`/`explorer`/`wslview`.
  - `*.md` — `:edit` the file relative to the current buffer.
  - Other targets log a debug warning.
- **`:WikiToggleCheckBox`** — Cycles the current line: `- [ ]` ↔ `- [x]`. Plain `- ` list items grow a checkbox; non-list lines get an indent-preserving checkbox prepended.
- **URL highlighting** — `https?://` and `mailto:` matches are added with `matchadd` in markdown buffers and styled via the `Hyperlink` highlight group (color from `links_color`). Per-window-guarded so re-entry doesn't stack duplicates.

## Lua API

All commands have a Lua counterpart for keymap wiring:

```lua
local nw = require("neowiki")

nw.find_files(name?, opts?)       -- defaults to default_wiki
nw.live_grep(name?, opts?)
nw.open_wiki(name?)
nw.select_wiki(action?)           -- "find_files" | "live_grep" | "open"
nw.path(name?)                    -- expanded path of the named wiki
nw.list()                         -- { { name, path, diary }, ... }
```

Example keymaps:

```lua
vim.keymap.set("n", "<leader>nd", function() require("neowiki").find_files("diary")    end)
vim.keymap.set("n", "<leader>np", function() require("neowiki").find_files("personal") end)
vim.keymap.set("n", "<leader>nw", function() require("neowiki").find_files("work")     end)
vim.keymap.set("n", "<leader>ns", require("neowiki").select_wiki)
vim.keymap.set("n", "<leader>ng", function() require("neowiki").live_grep() end)
```

## Picker support

NeoWiki has **no hard dependencies**. Pickers are detected at runtime via `pcall(require, ...)`:

| Backend       | Detected as          | Notes                                        |
| ------------- | -------------------- | -------------------------------------------- |
| telescope.nvim| `telescope.builtin`  | Uses `no_ignore_parent = true` for find.     |
| fzf-lua       | `fzf-lua`            | —                                            |
| snacks.picker | `snacks` + `.picker` | —                                            |
| mini.pick     | `mini.pick`          | —                                            |
| `vim.ui`      | always available     | `vim.fs.find` for files; `:vimgrep` for grep. Pure-Vim fallback so `WikiFind`/`WikiGrep` work without any picker plugin installed. |

`"auto"` walks the table above in order. Pin a specific one with `picker = "telescope"` etc. The choice is cached after first resolution.

## Caveats

- Markdown only. Filetype must be `markdown` for the autocmd-driven helpers (`gf`, URL highlighting) to engage.
- Single diary. Only one wiki may set `diary = true`. Multi-diary setups would require per-command `[name]` arguments — not implemented.
- The picker fallback's `:vimgrep` is synchronous and reads files on the main loop; fine for small wikis, painful for large ones. Install a real picker plugin if your wiki has more than a few hundred files.
- `WikiCreateIndex` only recognizes ATX headings (`#`, `##`, …). Setext headings (`===`/`---`) are ignored.

## See also

- `CLAUDE.md` — internal architecture notes and conventions.
- `doc/neowiki.txt` — `:h neowiki` (after running `:helptags doc/`).
