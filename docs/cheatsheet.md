# Cursor IDE: Cheatsheet

**Configuración y uso — Diciembre 2025**

> **Nota:** Este cheatsheet está basado en **Cursor IDE versión 2.2.20**. Algunas características pueden variar en versiones anteriores o posteriores.

---

## ADVERTENCIA: DATA SHARING

Por defecto, Cursor tiene **'Data Sharing Enabled'** activado.
Esto significa que **TU CÓDIGO se usa para entrenar sus modelos**.

Si trabajas con código propietario o sensible:

```
General > Privacy > Data Sharing > Cambia a 'Don't Share'
```

> Los embeddings del indexado también se almacenan en la nube (Turbopuffer).
> El código en sí no se almacena, pero los embeddings pueden ser reversibles.

---

## PARTE 1: ESTRUCTURA DE CURSOR SETTINGS

### Menú lateral (Cursor Settings)

| Sección | Qué configura |
|---------|---------------|
| General | Cuenta, layout, editor, privacidad |
| Agents | Comportamiento del Agent mode |
| Tab | Autocompletado con Tab |
| Models | Modelos disponibles y habilitados |
| Cloud Agents | Agentes en la nube (beta) |
| Tools & MCP | Herramientas y MCP servers |
| Rules and Commands | Reglas y comandos personalizados |
| Indexing & Docs | Indexado de codebase y documentación |
| Network | Proxy y configuración de red |
| Beta | Funciones experimentales |

---

## PARTE 2: CONFIGURACIÓN GENERAL (una sola vez)

### General

**Preferences**
- Default Layout: Agent o Editor (según preferencia)
- Editor Settings: Open → configurar fuente, minimap, etc.

**Notifications**
- System Notifications: ON (avisa cuando Agent termina)
- System Tray Icon: ON (icono en bandeja)
- Completion Sound: OFF (puede ser molesto)

**Privacy (IMPORTANTE)**

| Opción | Significado |
|--------|-------------|
| Share Data | Tu código entrena modelos de Cursor |
| Don't Share | Tu código NO se usa para entrenar |

### Agents

```
Default Mode: Agent           # Agent por defecto al abrir chat
Default Location: Pane        # Donde abre nuevos agents
Text Size: Default            # Tamaño de texto en chat

# Agent Review
Start Agent Review on Commit: ON   # Revisa cambios al commitear
Include Submodules: ON             # Incluye submódulos git
Include Untracked Files: ON        # Incluye archivos nuevos
Default Approach: Quick            # Quick o Thorough

# Context
Web Search Tool: ON                # Permite buscar en web
Auto-Accept Web Search: OFF        # Confirmar antes de buscar

# Auto-Run (equivalente al antiguo 'YOLO mode')
Auto-Run Mode: 'Ask Every Time'    # SEGURO: siempre pregunta
               'Auto-Run'          # PELIGROSO: ejecuta sin confirmar

# Protecciones
Browser Protection: ON             # Evita browser automático
File Deletion Protection: OFF      # Permite borrar archivos
Dotfile Protection: ON             # Protege .gitignore, etc.
External-File Protection: ON       # Protege archivos fuera del workspace
```

> **AVISO:** Auto-Run Mode en 'Auto-Run' ejecuta comandos sin confirmación. Solo activar si sabes lo que haces.

### Models (Plan Free vs Pro)

Modelos disponibles en Cursor 2.2 (diciembre 2025):

| Modelo | Descripción | Plan |
|--------|-------------|------|
| Composer 1 | Modelo propio de Cursor, rápido | Free/Pro |
| Opus 4.5 | Anthropic, máximo razonamiento | Pro (créditos) |
| Sonnet 4.5 | Anthropic, equilibrio calidad/velocidad | Pro (créditos) |
| Haiku 4.5 | Anthropic, rápido y económico | Free/Pro |
| GPT-5.1 / 5.2 | OpenAI, última generación | Pro (créditos) |
| GPT-5.1 Codex | OpenAI, optimizado para código | Pro (créditos) |
| Gemini 2.5 Flash | Google, muy rápido | Free/Pro |
| Gemini 3 Pro | Google, alta calidad | Pro (créditos) |
| Grok Code | xAI, alternativa | Pro (créditos) |

> **TIP:** Plan Free: acceso limitado a modelos premium (50 requests). Pro ($20/mes): pool de créditos de $20 para modelos premium.

### Indexing & Docs

**Codebase Indexing**
```
Index New Folders: OFF        # NO indexar automáticamente
                              # Indexar manualmente por proyecto

Ignore Files: Edit            # Abre .cursorignore

Index Repositories for Instant Grep: ON  # Acelera búsquedas
```

**Docs**
- Add Doc: Añadir documentación externa
- Ejemplo: `https://docs.python.org`
- Después usa `@Docs` en chat para referenciar

> **TIP:** Con 'Index New Folders: OFF', tú controlas cuando indexar cada proyecto. Más seguro y predecible.

---

## PARTE 3: TOOLS & MCP

### Configurar MCP (Model Context Protocol)

**Dos formas de configurar MCP:**

**Opción 1: Desde la UI**
```
Tools & MCP > Add Custom MCP > Seguir instrucciones
```

**Opción 2: Archivo mcp.json (recomendado)**
```bash
# MCP global (todos los proyectos):
~/.cursor/mcp.json

# MCP por proyecto:
<project-root>/.cursor/mcp.json
```

### Prerequisito: Node.js

```bash
# Verificar que tienes node y npx:
node --version    # Debe mostrar versión
npx --version     # Debe mostrar versión

# Si no tienes Node.js:
# Ubuntu/Debian:
sudo apt install nodejs npm

# Mac:
brew install node

# O descarga de: https://nodejs.org
```

### Configurar MCP de GitHub

**Paso 1:** Crear Personal Access Token en GitHub
```
github.com > Settings (tu perfil) > Developer settings
Personal access tokens > Tokens (classic)
Generate new token (classic)
Nombre: 'Cursor MCP', Expiration: 90 days
Scopes: marca 'repo' (acceso completo)
Generate token > COPIA el token (ghp_xxx)
```

**Paso 2:** Crear ~/.cursor/mcp.json
```bash
mkdir -p ~/.cursor
nano ~/.cursor/mcp.json
```

**Paso 3:** Contenido del archivo
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "ghp_TU_TOKEN_AQUI"
      }
    }
  }
}
```

**Paso 4:** Verificar
- Reinicia Cursor completamente
- Cursor Settings > Tools & MCP
- Debe aparecer 'github' con indicador verde

### Múltiples MCPs en un archivo

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": { "GITHUB_TOKEN": "ghp_xxx" }
    },
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": { "POSTGRES_URL": "postgresql://user:pass@localhost:5432/db" }
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/home/user/allowed"]
    }
  }
}
```

### Qué puedes hacer con MCP GitHub

En Chat, pide al Agent:

```
# Issues
'Lista los issues abiertos de este repo'
'Crea un issue: titulo X, descripción Y'
'Cierra el issue #15 con comentario'

# Pull Requests
'Revisa el PR #42 y busca bugs'
'Crea un PR con los cambios actuales'

# Repositorios
'Crea un repositorio privado llamado mi-api'
'Crea un repositorio público llamado utils-lib'

# Historial
'¿Cuándo se introdujo la función X?'
'¿Quién modificó este archivo por última vez?'
```

---

## PARTE 4: RULES AND COMMANDS

### Tipos de Rules

| Tipo | Descripción |
|------|-------------|
| User Rules | Globales, aplican a todos los proyectos |
| Project Rules | Solo para el proyecto actual (.cursor/rules/) |

**Crear User Rule (global):**
```
Rules and Commands > User Rules > + Add Rule
```

Ejemplos:
- 'Always respond in Spanish'
- 'Use TypeScript strict mode'
- 'Prefer async/await over callbacks'

**Crear Project Rule:**

```bash
# Opción 1: Desde UI
Rules and Commands > Project Rules > + Add Rule

# Opción 2: Archivo (recomendado)
# Crear: .cursor/rules/mi-regla.mdc
```

Contenido del archivo .mdc:
```yaml
---
description: Estándares del proyecto
alwaysApply: true
---

- Usa TypeScript estricto
- Funciones < 30 líneas
- Tests para funciones públicas
```

### Tipos de Commands

| Tipo | Ubicación |
|------|-----------|
| User Commands | ~/.cursor/commands/ y ~/.claude/commands/ |
| Project Commands | .cursor/commands/ |

**Crear Command:**

```bash
# Desde UI:
Rules and Commands > User Commands > + Add Command
Rules and Commands > Project Commands > + Add Command

# O crear archivo:
~/.cursor/commands/code-review.md
```

Contenido del comando:
```markdown
Revisa el código seleccionado:

1. Seguridad: SQL injection, XSS
2. Performance: N+1 queries
3. Legibilidad: nombres claros
4. Tests: cobertura

Severidad: CRÍTICO > ALTO > MEDIO > BAJO
```

> **TIP:** Los Commands aparecen en el menú de comandos. Usa `/nombre-comando` en chat para invocarlos.

### Soporte para CLAUDE.md

Cursor 2.2 soporta archivos CLAUDE.md (formato de Claude Code).

```
Rules and Commands > Import Settings:
  - Include CLAUDE.md in context: ON/OFF
  - Import Claude Commands: ON
```

---

## PARTE 5: WORKFLOW DE PROYECTO

### Al comenzar un proyecto nuevo

1. Abrir carpeta del proyecto en Cursor
2. Crear estructura: `mkdir -p .cursor/rules .cursor/commands`
3. Crear `.cursorignore` con archivos a excluir
4. Crear reglas del proyecto en `.cursor/rules/`
5. (Opcional) Crear `.cursor/mcp.json` si necesitas MCP específico
6. Indexar manualmente: Indexing & Docs > Compute Index
7. Esperar a que termine el indexado

### Cuándo re-indexar

Re-indexar manualmente cuando:
- Después de un merge grande
- Después de añadir muchos archivos nuevos
- Si notas que @Codebase no encuentra archivos recientes
- Semanalmente en proyectos activos

**Cómo re-indexar:**
```
Indexing & Docs > Resync Index
```

### Estructura de archivos de proyecto

```
mi-proyecto/
├── .cursor/
│   ├── rules/
│   │   ├── general.mdc      # Reglas generales
│   │   ├── react.mdc        # Reglas para React (si aplica)
│   │   └── api.mdc          # Reglas para API (si aplica)
│   ├── commands/
│   │   ├── code-review.md   # Comando de revisión
│   │   └── document.md      # Comando de documentación
│   └── mcp.json             # MCP específico del proyecto (opcional)
├── .cursorignore            # Archivos a ignorar en indexado
└── ... (resto del proyecto)
```

### Ejemplo .cursorignore

```gitignore
# Dependencias
node_modules/
venv/
.venv/

# Build
dist/
build/
.next/
coverage/

# Sensibles
.env
.env.*
*.pem
*.key

# Datos grandes
*.csv
*.sql
data/

# Otros
.git/
*.log
```

---

## REFERENCIA RÁPIDA

### Atajos de teclado

| Atajo | Acción |
|-------|--------|
| Cmd+L / Ctrl+L | Abrir Chat |
| Cmd+I / Ctrl+I | Abrir Composer |
| Cmd+K / Ctrl+K | Inline Edit (sobre selección) |
| Cmd+Shift+P | Command Palette |
| Cmd+Shift+J | Toggle Agent/Ask mode |
| Cmd+. | Cursor Settings |

### Símbolos @ (contexto)

| Símbolo | Qué hace |
|---------|----------|
| @archivo | Incluye archivo específico |
| @Codebase | Busca en todo el proyecto indexado |
| @Web | Busca en internet |
| @Docs | Busca en documentación añadida |
| @Git | Historial de Git |
| #archivo | En Composer, para editar archivo |

### Archivos de configuración

| Archivo | Ubicación |
|---------|-----------|
| MCP global | ~/.cursor/mcp.json |
| MCP proyecto | .cursor/mcp.json |
| Rules globales | Cursor Settings > Rules and Commands |
| Rules proyecto | .cursor/rules/*.mdc |
| Commands globales | ~/.cursor/commands/*.md |
| Commands proyecto | .cursor/commands/*.md |
| Ignorar indexado | .cursorignore |

### Checklist configuración inicial

- [ ] Decidir Data Sharing (General > Privacy)
- [ ] Desactivar Index New Folders (Indexing & Docs)
- [ ] Configurar Auto-Run Mode en 'Ask Every Time' (Agents)
- [ ] Instalar Node.js si vas a usar MCP
- [ ] (Opcional) Configurar MCP de GitHub
- [ ] (Opcional) Crear User Rules globales

---

**— Fin del Cheatsheet —**
