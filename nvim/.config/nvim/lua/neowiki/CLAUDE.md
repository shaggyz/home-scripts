# NeoWiki

Personal Neovim plugin (Lua). WIP. VimWiki-lite: named markdown knowledge bases + daily TODO files.

## Layout

Standard Neovim plugin layout (repo root = this directory):

```
neowiki/
├── lua/
│   └── neowiki/
│       ├── init.lua            -- bootstrap: setup(), commands, public Lua API
│       ├── wiki.lua            -- diary + markdown helpers + M.config defaults
│       ├── knowledge_base.lua  -- KB registry; backs WikiFind/Grep/Open/Select
│       ├── pickers.lua         -- picker backend shims (no hard deps)
│       └── utils.lua           -- pure helpers (slugify, dates, paths)
├── doc/neowiki.txt             -- vim help (placeholder; :helptags doc/ regenerates tags)
├── .gitignore
├── .luarc.json                 -- lua-language-server config (recognizes `vim`)
├── stylua.toml                 -- formatter config (4-space, double quotes)
├── CLAUDE.md
└── README.md                   -- user-facing notes (TBD)
```

No `plugin/` directory: the plugin requires explicit `require("neowiki").setup({...})`.
Compatible with lazy.nvim / packer / vim-plug / mini.deps out of the box — they only need a git repo.

## Architecture

`init.lua` returns module exposing `setup(user_config)` + public Lua API (`find_files`, `live_grep`, `select_wiki`, `open_wiki`, `path`, `list`) and re-exports `config` (shared table with `wiki.config`). Setup merges config, calls `kb.configure(cfg)` (which validates wikis + creates missing dirs + handles backwards-compat for `wiki_directory`), registers commands + `markdown` FileType autocmd for `gf` link follow.

`wiki.lua` requires `neowiki.utils` and (lazily, at call time) `neowiki.knowledge_base` to resolve the diary base path. `utils.lua` has no config dependency — all paths and base timestamps passed in. `knowledge_base.lua` requires `pickers.lua` and dispatches find/grep against the resolved adapter.

Daily files: `<diary_path>/YYYY/MM/YYYY-MM-DD.md` where `diary_path` is the registered diary wiki. New file uses previous-day content minus the date header and minus completed `- [x]` tasks (if `reuse_previous_day=true`); previous-day skips weekends when `weekdays_only=true`. Otherwise default `# TODO <date>` template.

## Config keys (defaults)

- `debug=false`
- `wikis=nil` — `{ name = { path, diary? } }`. Exactly one entry may set `diary=true`.
- `default_wiki=nil` — name used when commands/API called without one. Defaults to the diary wiki, then first registered.
- `picker="auto"` — `"auto" | "telescope" | "fzf-lua" | "snacks" | "mini" | "vim_ui"`.
- `wiki_directory="~/Notes"` — legacy shim. When `wikis` is empty, `knowledge_base.lua` synthesizes `wikis.default = { path = wiki_directory, diary = true }`.
- `auto_create_wiki_directory=true` — applied per-wiki on setup.
- `reuse_previous_day=true`
- `weekdays_only=false` — when true, `open_yesterday`/`open_tomorrow` skip Sat/Sun and `reuse_previous_day` pulls Friday's file on Mondays.
- `format_links=true`
- `links_color="#6cb6eb"`

## User commands

Diary/markdown: `WikiToday`, `WikiYesterday`, `WikiTomorrow`, `WikiCurrentMonth`, `WikiCreateLink`, `WikiCreateIndex`, `WikiFollowLink`, `WikiToggleCheckBox`.

Knowledge base: `WikiFind [name]`, `WikiGrep [name]`, `WikiOpen [name]`, `WikiSelect [action]` (action ∈ `find_files`/`live_grep`/`open`). All `[name]` args tab-complete from registered wikis.

## Lua API

`require("neowiki").find_files(name?, opts?)`, `.live_grep(name?, opts?)`, `.select_wiki(action?)`, `.open_wiki(name?)`, `.path(name?)`, `.list()`.

## Notable internals

- `slugify` — header → anchor slug.
- `create_index` — `vim.treesitter` markdown query on `atx_heading` h1–h6; wraps output in `<!-- neowiki:index:start -->` / `<!-- neowiki:index:end -->` sentinels so re-runs replace the prior block instead of stacking. Headers inside the existing block are skipped during capture.
- `follow_link` — `find_links(line)` parses `[label](target)` with balanced parens + backslash escapes (handles URLs like `Foo_(bar)`). `#anchor` → `go_to_header`, `http(s)://`/`mailto:` → `open_external` (uses `vim.ui.open` when available, otherwise `open`/`xdg-open`/`explorer`/`wslview`), `*.md` → edit relative to current file.
- `create_link` — wraps cword or visual selection as `[title](url)`, inserts clipboard URL when it matches `^https?://`, places cursor on the closing `)`.
- `handle_markdown_list` — continues `- `, `- [ ]`, or `:` indent on newline.
- `toggle_checkbox` — start-anchored: cycles `- [ ]` ↔ `- [x]/[X]`, adds checkbox to plain `- ` line, preserves leading indent on others.
- `set_format_links_autocmd` — `matchadd` Hyperlink group for `https?://` and `mailto:`; guarded by `vim.w.neowiki_links_set` to avoid stacking on FileType re-fires.
- `pickers.resolve(name)` — `"auto"` walks priority order `telescope → fzf-lua → snacks → mini → vim_ui` via `pcall(require)`; result cached. `vim_ui` fallback uses `vim.fs.find` for files and `:vimgrep` quickfix for grep.
- `kb.configure(cfg)` — validates entries, expands paths, mkdir's missing dirs (when `auto_create_wiki_directory`), enforces single diary, resolves `default_wiki`.

## Conventions

- 4-space indent, snake_case functions, local helpers above public `M.*`.
- All filesystem paths go through `vim.fn.expand` before use; all `:edit` calls `fnameescape`d.
- `utils.debug(msg, level, ctx)` is the only logger; gated by `wiki.config.debug` only at setup banner — function-level debug calls always print.
- Modules never `require` each other circularly. `wiki → utils` and `wiki → kb` (lazy); `kb → utils, pickers`; `init → wiki, kb, utils`.

## Open TODOs (from README + code)

- Publish (push to GitHub as a standalone repo; layout is already plugin-shaped).
- Inter-wiki links (e.g. `[label](work:notes/foo.md)`).
- Tag/backlink index.
- Flesh out `README.md` and `doc/neowiki.txt` once the API is stable.
