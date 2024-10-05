Keys:

# tmux 
tmux: ctrl + b
## Windows
 - new window: c
 - switch window: n
 - list windows: w
## Panes
 - new pane (natural numpad direction, like with mirrors):
    1: bottom left
    2: bottom (horizontal)
    3: bottom right
    4: left (vertical)
    
    6: right (vertical)
    7: top left
    8: top (horizontal)
    9: top right
Resize pane: shift plus arrow key

# nvim
<leader>: " "
The leader key is the key that is used to trigger  in nvim. It is set to space.

nvim windows: ctrl + w
 - split horizontally: s
 - split vertically: v
 - close window: q
 - move to window: h, j, k, l
 - resize window: +, -


Plugins:
telescope: handles file search, git files, etc.
    - <space>ff: find files
    - <space>fg: find git files
    - <space>fb: find buffers
    - <space>fh: find help tags
    - <space>fl: find live grep
    - <space>ft: find tags
    - <space>fr: find recent files
    - <space>fw: find word
    - <space>fc: find commands
    - <space>fm: find

neotree: file browser
    - <space>e: toggle Explorer

notify: for displaying terminal output in a notification
    - :Notify "message"

lualine: handles top and bottom bar of nvim
    -  bufferline: handles the tabs at the top

chatgpt: for editing, chatting, and explaining
    - <space>a: for ai menu
        - <space>ag: for chatgpt menu
            - <space>age: for chatgpt edit
            - <space>agd: for chatgpt explain
            - <space>agc: for chatgpt chat

neogit: for git integration
    - <space>g: for neogit
        - <space>gs: for git status
        - <space>gc: for git commit
        - <space>gp: for git push
        - <space>gd: for git diff
        - <space>gb: for git blame

lazygit: for more complex git operations, like mergin conflicts, squashing, etc.
    - :LazyGit

coc: for autocompletion
copilot: for autocompletion
    cycle through suggestions: ctrl + n, ctrl + p
 

