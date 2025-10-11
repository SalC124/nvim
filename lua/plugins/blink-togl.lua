return {
    "saghen/blink.cmp",
    opts = function(_, opts)
        -- Enable completion by default when a buffer is opened
        vim.api.nvim_create_autocmd("BufEnter", {
            callback = function()
                if vim.b.completion == nil then
                    vim.b.completion = true
                end
            end,
        })
        local completion_toggle = Snacks.toggle({
            name = "Completion",
            get = function()
                return vim.b.completion
            end,
            set = function(state)
                vim.b.completion = state
            end,
        })


        local function toggle_completion()
            require("blink.cmp").hide()
            completion_toggle:toggle()
        end

        vim.keymap.set({ "n" }, "<leader>iq", toggle_completion, { desc = "Toggle Completion" })
        opts.enabled = function()
            return vim.b.completion
        end

        return opts
    end,
}
