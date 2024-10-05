# Installation

### Install dependencies
``` brew install tmux ```

``` brew install neovim ```

To avoid Lazyvim warnings install lua 5.1.5 from source
```
   wget https://www.lua.org/ftp/lua-5.1.5.tar.gz
   tar zxf lua-5.1.5.tar.gz
   cd lua-5.1.5
   make macosx
   sudo make install
```

# Usage

```
tmux
tmux source-file ~/.tmux.conf # Reload config
nvim
```
`ctrl + b` `2` # Create new pane in bottom

`ctrl + b` `o` # Switch back to nvim


### Clone repo and install plugins
```
git clone git@github.com:meetorman/terminal-god.git
mv terminal-god/.tmux.conf ~/.tmux.conf
mv terminal-god/.config/nvim ~/.config/nvim
```

# Key Bindings

## tmux

### Windows
![](./readme/tmux-windows.png)

Prefix: `Ctrl + b`
- New window: `c`
- Switch window: `n`
- List windows: `w`

### Panes
![](./readme/tmux-panes.png)
New pane (numpad direction):
- `1`: bottom left
- `2`: bottom (horizontal)
- `3`: bottom right
- `4`: left (vertical)
- `6`: right (vertical)
- `7`: top left
- `8`: top (horizontal)
- `9`: top right

Resize pane: `Shift + Arrow key`

## nvim

Leader key: `Space`

### Windows
![](./readme/nvim-windows.png)
Prefix: `Ctrl + w`
- Split horizontally: `s`
- Split vertically: `v`
- Close window: `q`
- Move to window: `h`, `j`, `k`, `l`
- Resize window: `+`, `-`

## Plugins

### telescope
![](./readme/telescope.png)
File search, git files, etc.
- Find files: `<space>ff`
- Find git files: `<space>fg`
- Find buffers: `<space>fb`
- Find help tags: `<space>fh`
- Find live grep: `<space>fl`
- Find tags: `<space>ft`
- Find recent files: `<space>fr`
- Find word: `<space>fw`
- Find commands: `<space>fc`
- Find: `<space>fm`

### neotree
![](./readme/neotree.png)
File browser
- Toggle Explorer: `<space>e`

### notify
![](./readme/notify.png)
Display background terminal output in a notification, allows plugins to send notifications
- Usage: `:Notify "message"`

### lualine
![](./readme/lualine-top.png)
![](./readme/lualine-bottom.png)
Handles top and bottom bar of nvim
- bufferline: Handles the tabs at the top

### chatgpt
![](./readme/chatgpt.png)
For editing, chatting, and explaining
- AI menu: `<space>a`
  - ChatGPT menu: `<space>ag`
    - Edit: `<space>age`
    - Explain: `<space>agd`
    - Chat: `<space>agc`

### neogit
![](./readme/neogit.png)
For quick git operations
- Neogit menu: `<space>g`
  - Git status: `<space>gs`
  - Git commit: `<space>gc`
  - Git push: `<space>gp`
  - Git diff: `<space>gd`
  - Git blame: `<space>gb`

### lazygit
![](./readme/lazygit.png)
For more complex git operations (merging conflicts, squashing, etc.)
- Usage: `:LazyGit`

### Autocompletion
#### CoPilot
- Cycle through suggestions: `Ctrl + n`, `Ctrl + p`
#### COC
![](./readme/coc.png)
### which-key
Provides menu for key binding reminders
#### Windows
![](./readme/which-key-windows.png)
#### Leader <space>
![](./readme/which-key-leader.png)
#### Miscellaneous
![](./readme/which-key-z.png)
