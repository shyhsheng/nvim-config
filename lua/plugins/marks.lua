return {
    "chentoast/marks.nvim",
    event = "BufReadPre",
    config = function()
        require("marks").setup({
            -- Show built-in marks (like '[ and `])
            default_mappings = true,
            -- Whether to show marks in the signcolumn
            signcolumn = true,
            -- Automatically save and restore marks between sessions
            -- Requires a session manager plugin if set to true
            persist_signs = true,
            -- Marks shown in the signcolumn (can customize per letter)
            excluded_filetypes = {},
            bookmark_0 = {
                sign = "⚑", -- or any icon you like
                virt_text = "Bookmark",
            },
            mappings = {
                next = "<F2>",
                prev = "<F14>", -- Shift + F2
            }
        })
    end,
}
    -- 'a              Move to specific mark
    -- mx              Set mark x
    -- m,              Set the next available alphabetical (lowercase) mark
    -- m;              Toggle the next available mark at the current line
    -- dmx             Delete mark x
    -- dm-             Delete all marks on the current line
    -- dm<space>       Delete all marks in the current buffer
    -- m]              Move to next mark
    -- m[              Move to previous mark
    -- m:              Preview mark. This will prompt you for a specific mark to
    --                 preview; press <cr> to preview the next mark.
    --
    -- m[0-9]          Add a bookmark from bookmark group[0-9].
    -- dm[0-9]         Delete all bookmarks from bookmark group[0-9].
    -- m}              Move to the next bookmark having the same type as the bookmark under
    --                 the cursor. Works across buffers.
    -- m{              Move to the previous bookmark having the same type as the bookmark under
    --                 the cursor. Works across buffers.
    -- dm=             Delete the bookmark under the cursor.
