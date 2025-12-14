# cursor-init Makefile
#
# Uso:
#   make install          Instala en ~/.local/bin/
#   make uninstall        Desinstala
#   make install PREFIX=/usr/local   Instala en /usr/local/bin/
#

PREFIX ?= $(HOME)/.local
BINDIR = $(PREFIX)/bin
CURDIR_ABS = $(shell pwd)

.PHONY: install uninstall help

help:
	@echo "cursor-init - Herramientas para Cursor IDE"
	@echo ""
	@echo "Uso:"
	@echo "  make install          Instala en ~/.local/bin/"
	@echo "  make uninstall        Desinstala"
	@echo "  make install PREFIX=/usr/local   Instala globalmente"
	@echo ""

install:
	@mkdir -p $(BINDIR)
	@ln -sf $(CURDIR_ABS)/bin/cursor-init $(BINDIR)/cursor-init
	@ln -sf $(CURDIR_ABS)/bin/cursor-config $(BINDIR)/cursor-config
	@chmod +x $(CURDIR_ABS)/bin/cursor-init
	@chmod +x $(CURDIR_ABS)/bin/cursor-config
	@echo ""
	@echo "✓ Instalado:"
	@echo "  - cursor-init"
	@echo "  - cursor-config"
	@echo ""
	@echo "  Location: $(BINDIR)/"
	@echo ""
	@if echo "$$PATH" | grep -q "$(BINDIR)"; then \
		echo "✅ Installation complete!"; \
	else \
		echo "⚠ Setup notes:"; \
		echo "  • $(BINDIR) is not in your PATH. Run:"; \
		echo ""; \
		echo "  echo 'export PATH=\"$(BINDIR):\$$PATH\"' >> ~/.bashrc && source ~/.bashrc"; \
		echo ""; \
	fi

uninstall:
	@rm -f $(BINDIR)/cursor-init
	@rm -f $(BINDIR)/cursor-config
	@echo ""
	@echo "✓ Desinstalado"
	@echo ""
