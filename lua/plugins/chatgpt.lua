return {
        'jackMort/ChatGPT.nvim',
        requires = { 
            'nvim-lua/plenary.nvim', 
            'nvim-telescope/telescope.nvim', 
            'MunifTanjim/nui.nvim'
        },
        config = function()
            require("chatgpt").setup({
                api_key_cmd = "echo $OPENAI_API_KEY"
            })
        end
    }
