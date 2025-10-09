require "nvchad.options"

-- add yours here!

local o = vim.o
-- Indenting
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.wrap = true -- Enable word wrap
o.linebreak = true -- Break lines at word boundaries
o.breakindent = true -- Maintain indentation on wrapped lines
o.textwidth = 0 -- Disable automatic line breaking
o.wrapmargin = 0 -- Disable wrapping based on margin
-- o.cursorlineopt ='both' -- to enable cursorline!
