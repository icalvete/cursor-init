# cursor-init

<p align="center">
  <img src="assets/cursor-logo.png" alt="Cursor IDE" width="400">
</p>

Herramientas para configurar y usar [Cursor IDE](https://cursor.com) de forma productiva y segura.

> **Importante:** Si es tu primera vez con Cursor IDE, te recomendamos leer el [Tutorial Básico](docs/tutorial-basico.md) antes de usar este proyecto. Entender los conceptos de Chat, Composer, símbolos @, Rules y Commands te ayudará a sacar el máximo provecho de `cursor-init` y `cursor-config`.

## ¿Por qué?

Cursor es un IDE potente basado en VS Code con capacidades de IA integradas. Sin embargo, la configuración por defecto no siempre es la más segura o productiva:

- **Data Sharing activado por defecto**: Tu código puede usarse para entrenar modelos
- **Auto-Run habilitado**: El agente puede ejecutar comandos sin confirmación
- **Indexado automático**: Puede indexar carpetas con datos sensibles sin que lo sepas
- **Sin estructura de proyecto**: Cada proyecto empieza de cero, sin reglas ni comandos predefinidos

Este proyecto resuelve esos problemas con dos herramientas:

| Herramienta | Qué hace |
|-------------|----------|
| `cursor-init` | Inicializa proyectos con reglas de estilo, comandos y configuración MCP |
| `cursor-config` | Configura Cursor globalmente con opciones seguras y permite backup/restore |

## Ventajas

- **Configuración segura por defecto**: Telemetría desactivada, Auto-Run con confirmación, protecciones activadas
- **Consistencia entre proyectos**: Mismas reglas de estilo y documentación en todos tus proyectos
- **Portabilidad**: Backup y restore de tu configuración para usarla en cualquier máquina
- **Multi-lenguaje**: Reglas para Ruby, Python y JavaScript/TypeScript incluidas
- **Extensible**: Fácil de añadir nuevos lenguajes, frameworks o MCPs

## Instalación
```bash
git clone https://github.com/icalvete/cursor-init.git
cd cursor-init
make install
```

Por defecto instala en `~/.local/bin/`. Para instalar en `/usr/local/bin/`:
```bash
sudo make install PREFIX=/usr/local
```

## Uso rápido
```bash
# Configurar Cursor con opciones seguras (solo una vez)
cursor-config setup

# Crear un proyecto nuevo
cursor-init ~/proyectos/mi-app

# Con Rails
cursor-init ~/proyectos/mi-app --rails

# Con MCP de GitHub
cursor-init ~/proyectos/mi-app --mcp-github

# Backup de tu configuración
cursor-config backup ~/cursor-backup

# Restaurar en otra máquina
cursor-config restore ~/cursor-backup
```

## cursor-init

Inicializa proyectos con estructura para Cursor.
```bash
cursor-init <directorio> [opciones]
```

### Opciones

| Opción | Descripción |
|--------|-------------|
| `--rails` | Añade reglas para Ruby on Rails |
| `--mcp-github` | Añade configuración MCP para GitHub |
| `--mcp-postgres` | Añade configuración MCP para PostgreSQL |

### Qué incluye por defecto

**Lenguajes:**
- Ruby (estilo + documentación YARD)
- Python (PEP8 + Google-style docstrings)
- JavaScript/TypeScript (ES6+ + JSDoc)

**Comandos:**
- `/document` - Documenta código según el lenguaje
- `/review` - Code review por severidad

### Estructura generada
```
mi-proyecto/
├── .cursor/
│   ├── rules/           # Reglas de estilo y documentación
│   ├── commands/        # Comandos reutilizables
│   └── mcp.json         # Configuración MCP (si se solicita)
└── .cursorignore        # Archivos ignorados en indexado
```

## cursor-config

Gestiona la configuración global de Cursor.
```bash
cursor-config <comando> [argumentos]
```

### Comandos

| Comando | Descripción |
|---------|-------------|
| `setup` | Aplica configuración recomendada |
| `show` | Muestra configuración actual |
| `backup <dir>` | Guarda backup de configuración |
| `restore <dir>` | Restaura desde backup |
| `extensions list` | Lista extensiones instaladas |

### Configuración recomendada (setup)

| Configuración | Valor | Por qué |
|---------------|-------|---------|
| Data Sharing | OFF | Tu código no entrena modelos |
| Index New Folders | OFF | Indexas manualmente cada proyecto |
| Auto-Run Mode | Ask Every Time | Siempre pide confirmación |
| Web Search Tool | ON | El agente puede buscar en internet |
| File Deletion Protection | ON | Previene borrados accidentales |
| Dotfile Protection | ON | Protege .gitignore, .env, etc. |
| External-File Protection | ON | Protege archivos fuera del proyecto |

### Backup y Restore
```bash
# Guardar configuración
cursor-config backup ~/cursor-backup

# Restaurar en otro PC
cursor-config restore ~/cursor-backup
```

El backup incluye:
- `settings.json` (configuración principal)
- `keybindings.json` (atajos de teclado)
- `snippets/` (snippets personalizados)
- `mcp.json` (MCP global)
- `extensions.txt` (lista de extensiones)

## Personalización

Los templates están en `templates/`. Puedes:

- Editar reglas existentes en `templates/<lenguaje>/rules/`
- Añadir nuevos lenguajes creando carpetas con la misma estructura
- Crear comandos en `templates/commands/`
- Añadir configuraciones MCP en `templates/mcp/`

## Requisitos

- Bash
- [jq](https://stedolan.github.io/jq/) (para cursor-config)
- [Cursor IDE](https://cursor.com)
```bash
# Ubuntu/Debian
sudo apt install jq
```

## Documentación

### Guías incluidas

En la carpeta [`docs/`](docs/) encontrarás tutoriales completos para aprender a usar Cursor IDE:

| Documento | Descripción |
|-----------|-------------|
| [Tutorial Básico](docs/tutorial-basico.md) | Introducción completa: instalación, interfaces, símbolos @ y reglas |
| [Tutorial Avanzado](docs/tutorial-avanzado.md) | Agent Mode, MCP, Commands, CLI y workflows (TDD, refactoring) |
| [Cheatsheet](docs/cheatsheet.md) | Referencia rápida: configuración, atajos, MCP y checklist de seguridad |
| [POC: Ruby + Sinatra](docs/poc-ruby-sinatra.md) | Proyecto práctico que demuestra todas las características de Cursor |

### Enlaces externos

- [Cursor IDE](https://cursor.com)
- [Cursor Documentation](https://docs.cursor.com)

## Desinstalación
```bash
cd cursor-init
make uninstall
```

## Licencia

MIT
