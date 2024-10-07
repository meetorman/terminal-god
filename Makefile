TERMINAL_GOD_DIR=$(INST_LUADIR)/terminal-god

install:
	mkdir -p $(TERMINAL_GOD_DIR)
	cp -R * $(TERMINAL_GOD_DIR)

uninstall:
	rm -rf $(TERMINAL_GOD_DIR)