#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

# Get the user's home directory
USER_HOME=$HOME

# Create necessary directories
mkdir -p "$USER_HOME/.local"
mkdir -p "$USER_HOME/.local/bin"
mkdir -p "$USER_HOME/.local/lib"
mkdir -p "$USER_HOME/.local/share/lua/5.1"
mkdir -p "$USER_HOME/.local/lib/lua/5.1"
mkdir -p "$USER_HOME/.luarocks"

# Download and install Lua
cd /tmp
curl -R -O https://www.lua.org/ftp/lua-5.1.5.tar.gz
tar zxf lua-5.1.5.tar.gz
cd lua-5.1.5
make macosx INSTALL_TOP="$USER_HOME/.local"
make install INSTALL_TOP="$USER_HOME/.local"

# Download and install LuaRocks
cd /tmp
curl -R -O https://luarocks.github.io/luarocks/releases/luarocks-3.11.1.tar.gz
tar zxf luarocks-3.11.1.tar.gz
cd luarocks-3.11.1
./configure --prefix="$USER_HOME/.local" \
            --with-lua="$USER_HOME/.local" \
            --sysconfdir="$USER_HOME/.local/etc/luarocks" \
            --force-config
make build
make install

# Configure LuaRocks
$USER_HOME/.local/bin/luarocks config --local lua_dir $USER_HOME/.local
$USER_HOME/.local/bin/luarocks config --local lua_interpreter $USER_HOME/.local/bin/lua

# Set up LuaRocks environment
echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$USER_HOME/.zshrc"
echo 'eval $($HOME/.local/bin/luarocks path --bin)' >> "$USER_HOME/.zshrc"

# Create custom LuaRocks configuration
cat > "$USER_HOME/.luarocks/config-5.1.lua" << EOL
rocks_trees = {
  { name = "user", root = "$USER_HOME/.local" }
}
lua_interpreter = "$USER_HOME/.local/bin/lua"
variables = {
  LUA_DIR = "$USER_HOME/.local",
  LUA_INCDIR = "$USER_HOME/.local/include",
  LUA_LIBDIR = "$USER_HOME/.local/lib",
  LUA_BINDIR = "$USER_HOME/.local/bin",
}
EOL

echo "Installation complete. Please run 'source ~/.zshrc' to update your current shell session."
