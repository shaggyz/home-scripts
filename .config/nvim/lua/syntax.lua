--------------------------------------------------------------------------------
-- ❇ Custom syntax stuff (for rosepine)
--------------------------------------------------------------------------------

-- Rosepine pallete: https://rosepinetheme.com/palette/ingredients/
local Black = '#000000'
local DarkGreen = '#31748f'
local DarkGrey = '#474556'
local DarkYellow = '#f6c177'
local Grey = '#908caa'
local Green = '#56949f'
local LightBlue = '#3e8fb0'
local LightGreen = '#9ccfd8'
local LightGrey = '#a3a0b5'
local LighterGreen = '#d9fbeb'
local LighterYellow = '#fbf1d9'
local Red = '#eb6f92'
local White = '#ffffff'
local Yellow = '#fee1b8'

-- Global
vim.api.nvim_set_hl(0, '@type', { fg = LighterGreen, italic = false })
vim.api.nvim_set_hl(0, '@variable.builtin.vim', { fg = LightGreen, bold = false })
vim.api.nvim_set_hl(0, '@string.special.url.vimdoc', { fg = LightBlue, underline = true })

-- Markdown
-- vim.api.nvim_set_hl(0, '@markup.raw.block.markdown', { bg = Black })
-- vim.api.nvim_set_hl(0, 'mkdCodeStart', { bg = Black })

-- Python
vim.api.nvim_set_hl(0, '@variable.parameter.python', { fg = LighterYellow, italic = false })
vim.api.nvim_set_hl(0, '@variable.python', { italic = false })
vim.api.nvim_set_hl(0, '@operator.python', { fg = DarkGreen })
vim.api.nvim_set_hl(0, '@constant.builtin.python', { fg = DarkGreen, bold = false })
vim.api.nvim_set_hl(0, '@function.method.call.python', { fg = LightGreen })
vim.api.nvim_set_hl(0, '@function.call.python', { fg = White })
vim.api.nvim_set_hl(0, '@string.documentation.python', { fg = Grey })
vim.api.nvim_set_hl(0, '@string.python', { fg = Yellow })
vim.api.nvim_set_hl(0, '@variable.builtin.python', { fg = DarkGreen, bold = false })
vim.api.nvim_set_hl(0, '@attribute.builtin.python', { fg = DarkGreen, bold = false })
vim.api.nvim_set_hl(0, '@attribute.python', { fg = DarkGreen, bold = false })
vim.api.nvim_set_hl(0, '@spell.python', { fg = Grey, bold = false, italic = true })

-- Bash
vim.api.nvim_set_hl(0, '@constant.bash', { fg = DarkGreen })
vim.api.nvim_set_hl(0, '@string.bash', { fg = Yellow })

-- Custom queries for python (~/.config/nvim/queries/python/highlights.scm)
vim.api.nvim_set_hl(0, '@decorator.identifier.python', { fg = DarkGreen })
vim.api.nvim_set_hl(0, '@decorator.function.object.python', { fg = DarkGreen })
vim.api.nvim_set_hl(0, '@decorator.function.attribute.python', { fg = LightGreen })

-- Coc colors
vim.api.nvim_set_hl(0, 'CocUnusedHighlight', { fg = LightGrey })

-- following colors are not fully working
vim.api.nvim_set_hl(0, 'CocHintSign', { fg = LightBlue })
vim.api.nvim_set_hl(0, 'CocHintVirtualText', { fg = LightBlue })
vim.api.nvim_set_hl(0, 'CocHintFloat', { fg = LightBlue })
vim.api.nvim_set_hl(0, 'CocInlayHint', { fg = LightBlue })

vim.api.nvim_set_hl(0, 'CocInfoSign', { fg = LightBlue })
vim.api.nvim_set_hl(0, 'CocInfoVirtualText', { fg = LightBlue })
vim.api.nvim_set_hl(0, 'CocInfoFloat', { fg = LightBlue })
vim.api.nvim_set_hl(0, 'CocInlayInfo', { fg = LightBlue })

vim.api.nvim_set_hl(0, 'CocErrorSign', { fg = Red })
vim.api.nvim_set_hl(0, 'CocErrorVirtualText', { fg = Red })
vim.api.nvim_set_hl(0, 'CocErrorFloat', { fg = Red })
vim.api.nvim_set_hl(0, 'CocInlayError', { fg = Red })

vim.api.nvim_set_hl(0, 'CocWarningSign', { fg = Yellow })
vim.api.nvim_set_hl(0, 'CocWarningVirtualText', { fg = Yellow })
vim.api.nvim_set_hl(0, 'CocWarningFloat', { fg = Yellow })
vim.api.nvim_set_hl(0, 'CocInlayWarning', { fg = Yellow })

-- Nvim tree colors (use the :NvimTreeHiTest command to check the available groups):
vim.api.nvim_set_hl(0, 'NvimTreeFolderName', { fg = DarkGreen })
vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { fg = LightBlue })
vim.api.nvim_set_hl(0, 'NvimTreeGitIgnoredIcon', { fg = LightGrey })
vim.api.nvim_set_hl(0, 'NvimTreeGitFileIgnoredHL', { fg = LightGrey })
vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = DarkGrey })
vim.api.nvim_set_hl(0, 'NvimTreeRootFolder', { fg = DarkGreen })

vim.api.nvim_set_hl(0, 'NvimTreeModifiedIcon', { fg = Red })
vim.api.nvim_set_hl(0, 'NvimTreeModifiedFileHL', { fg = DarkYellow })
vim.api.nvim_set_hl(0, 'NvimTreeGitDirtyIcon', { fg = DarkYellow })
vim.api.nvim_set_hl(0, 'NvimTreeGitFolderDirtyHL', { fg = DarkGreen })
vim.api.nvim_set_hl(0, 'NvimTreeGitFileDirtyHL', { fg = LighterYellow })
vim.api.nvim_set_hl(0, 'NvimTreeGitStagedIcon', { fg = Green })
vim.api.nvim_set_hl(0, 'NvimTreeGitFolderStagedHL', { fg = DarkGreen })
vim.api.nvim_set_hl(0, 'NvimTreeGitFileStagedHL', { fg = Green })



-- YAML
vim.api.nvim_set_hl(0, 'yamlBlockMappingKey', { fg = DarkGreen })
