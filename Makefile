# ============================================================
#  Makefile — Setup y comandos para el taller ADK
#  macOS / Linux
# ============================================================

.PHONY: setup install-uv install-python create-venv install-deps check-env verify run run-1 run-2 run-3 run-4 clean help

# Colores
GREEN  := \033[0;32m
YELLOW := \033[0;33m
CYAN   := \033[0;36m
RED    := \033[0;31m
RESET  := \033[0m

# ── Setup completo ──────────────────────────────────────────
setup: install-uv install-python create-venv install-deps check-env verify  ## Instalar todo (uv + Python + .venv + deps)
	@echo ""
	@echo "$(GREEN)========================================"
	@echo "  ✓ Setup completado!"
	@echo "========================================$(RESET)"
	@echo ""
	@echo "$(CYAN)Siguientes pasos:$(RESET)"
	@echo "  1. Agrega tu API Key en .env"
	@echo "  2. Ejecuta:  make run"
	@echo "  3. Abre:     http://localhost:8000"
	@echo ""

# ── 1. Instalar uv ──────────────────────────────────────────
install-uv:  ## Instalar uv
	@echo ""
	@echo "$(YELLOW)[1/5] Verificando uv...$(RESET)"
	@if command -v uv >/dev/null 2>&1; then \
		echo "  $(GREEN)✓ uv ya instalado: $$(uv --version)$(RESET)"; \
	else \
		echo "  → Instalando uv..."; \
		curl -LsSf https://astral.sh/uv/install.sh | sh; \
		echo "  $(GREEN)✓ uv instalado$(RESET)"; \
		echo "  $(YELLOW)→ Recarga tu terminal: source ~/.bashrc  o  source ~/.zshrc$(RESET)"; \
	fi

# ── 2. Instalar Python ──────────────────────────────────────
install-python:  ## Instalar Python 3.12 via uv
	@echo ""
	@echo "$(YELLOW)[2/5] Verificando Python 3.12...$(RESET)"
	@if uv python find 3.12 >/dev/null 2>&1; then \
		echo "  $(GREEN)✓ Python 3.12 encontrado$(RESET)"; \
	else \
		echo "  → Instalando Python 3.12 via uv..."; \
		uv python install 3.12; \
		echo "  $(GREEN)✓ Python 3.12 instalado$(RESET)"; \
	fi

# ── 3. Crear .venv ──────────────────────────────────────────
create-venv:  ## Crear entorno virtual .venv
	@echo ""
	@echo "$(YELLOW)[3/5] Creando entorno virtual .venv...$(RESET)"
	@if [ -f .venv/bin/python ]; then \
		echo "  $(GREEN)✓ .venv ya existe: $$(.venv/bin/python --version)$(RESET)"; \
	elif [ -d .venv ]; then \
		echo "  → .venv corrupto, recreando..."; \
		rm -rf .venv; \
		uv venv --python 3.12; \
		echo "  $(GREEN)✓ .venv recreado$(RESET)"; \
	else \
		uv venv --python 3.12; \
		echo "  $(GREEN)✓ .venv creado con Python 3.12$(RESET)"; \
	fi

# ── 4. Instalar dependencias ────────────────────────────────
install-deps:  ## Instalar dependencias en .venv
	@echo ""
	@echo "$(YELLOW)[4/5] Instalando dependencias en .venv...$(RESET)"
	@uv sync
	@echo "  $(GREEN)✓ google-adk instalado en .venv$(RESET)"

# ── 5. Verificar .env ───────────────────────────────────────
check-env:  ## Verificar .env con API Key
	@echo ""
	@echo "$(YELLOW)[5/5] Verificando configuracion...$(RESET)"
	@if [ -f .env ] && grep -q "GOOGLE_API_KEY=AIza" .env; then \
		echo "  $(GREEN)✓ .env configurado con API Key$(RESET)"; \
	elif [ -f .env ]; then \
		echo "  $(YELLOW)⚠ .env existe pero falta GOOGLE_API_KEY$(RESET)"; \
		echo "    → Edita .env y agrega tu API Key de aistudio.google.com"; \
	else \
		cp .env.example .env 2>/dev/null || echo "GOOGLE_API_KEY=" > .env; \
		echo "  $(YELLOW)⚠ Archivo .env creado. Agrega tu API Key:$(RESET)"; \
		echo "    → Abre .env y pega tu GOOGLE_API_KEY"; \
		echo "    → Obtener gratis en: https://aistudio.google.com"; \
	fi

# ── Verificación final ──────────────────────────────────────
verify:  ## Verificar que todo está instalado correctamente
	@echo ""
	@echo "$(CYAN)========================================$(RESET)"
	@echo "$(CYAN)  Verificacion final$(RESET)"
	@echo "$(CYAN)========================================$(RESET)"
	@echo "  Python:     $$(.venv/bin/python --version)"
	@echo "  google-adk: $$(uv run python -c 'import google.adk; print(google.adk.__version__)' 2>/dev/null || echo 'instalado')"
	@echo "  uv:         $$(uv --version)"

# ── Correr prácticas ────────────────────────────────────────
run:  ## Abrir el playground ADK (todas las prácticas)
	uv run adk web .

run-1:  ## Práctica 1: Agente básico
	uv run adk web practica_1_basico

run-2:  ## Práctica 2: Agente + Tools
	uv run adk web practica_2_tools

run-3:  ## Práctica 3: Multi-agente
	uv run adk web practica_3_multi

run-4:  ## Práctica 4: Agente de voz
	uv run adk web practica_4_voz

# ── Limpiar ──────────────────────────────────────────────────
clean:  ## Borrar .venv y archivos generados
	rm -rf .venv __pycache__ .adk
	@echo "$(GREEN)✓ Limpieza completada$(RESET)"

# ── Help ─────────────────────────────────────────────────────
help:  ## Mostrar esta ayuda
	@echo ""
	@echo "$(CYAN)Comandos disponibles:$(RESET)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-15s$(RESET) %s\n", $$1, $$2}'
	@echo ""
