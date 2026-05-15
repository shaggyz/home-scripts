# NeoWiki

Personal Neovim plugin (Lua). WIP. VimWiki-lite for one Markdown knowledge base + daily TODO files.

## Layout

- `init.lua` — entire plugin: config, commands, autocmds.
- `wiki.lua` — empty stub.
- `README.md` — user-facing notes.

## Architecture

Single module `neowiki` returned from `init.lua`. `neowiki.setup(user_config)` merges config, ensures `wiki_directory` exists, registers user commands + a `markdown` FileType autocmd for `gf` link follow.

Daily files: `<wiki_directory>/YYYY/MM/YYYY-MM-DD.md`. New file uses yesterday's content minus the date header and minus completed `- [x]` tasks (if `reuse_previous_day=true`), else default `# TODO <date>` template.

## Config keys (defaults)

- `debug=false`
- `wiki_directory="~/Notes"`
- `auto_create_wiki_directory=true`
- `reuse_previous_day=true`
- `format_links=true`
- `links_color="#6cb6eb"`

## User commands

`WikiToday`, `WikiYesterday`, `WikiTomorrow`, `WikiCurrentMonth`, `WikiCreateLink`, `WikiCreateIndex`, `WikiFollowLink`, `WikiToggleCheckBox`.

## Notable internals

- `slugify` — header → anchor slug.
- `create_index` — uses `vim.treesitter` markdown query on `atx_heading` h1–h6, prepends `# Index` block.
- `follow_link` — parses `[label](target)` under cursor; `#anchor` → `go_to_header`, `http*` → `open` (macOS), `*.md` → edit relative to current file.
- `create_link` — wraps cword or visual selection as `[title]()`, pastes clipboard URL if it matches `^https?://`, places cursor between `()`.
- `handle_markdown_list` — continues `- `, `- [ ]`, or `:` indent on newline.
- `toggle_checkbox` — cycles `- [ ]` ↔ `- [x]`, adds checkbox to plain `- ` line.
- `set_format_links_autocmd` — `matchadd` Hyperlink group for `https?://` and `mailto:`.

## Conventions

- 4-space indent, snake_case functions, local helpers above public `neowiki.*`.
- All filesystem paths go through `vim.fn.expand` before use.
- `debug(msg, level, ctx)` is the only logger; gated by `neowiki.config.debug` only at setup banner — function-level debug calls always print.

## Open TODOs (from README + code)

- `reuse_previous_day` weekday-only option.
- Replace `get_yesterday_date`/`get_tomorrow_date` with `get_relative_date`.
- Restructure as redistributable plugin; publish.
