# cursor-init

Herramientas para configurar y usar Cursor IDE de forma productiva.

Incluye dos comandos:
- **`cursor-init`**: Inicializa proyectos con reglas, comandos y MCP
- **`cursor-config`**: Configura Cursor globalmente (setup, backup, restore)

## Instalación

```bash
git clone https://github.com/tu-usuario/cursor-init.git
cd cursor-init
make install
```

Por defecto instala en `~/.local/bin/`. Para instalar en `/usr/local/bin/`:

```bash
sudo make install PREFIX=/usr/local
```

## Uso

```bash
# Crear proyecto nuevo con Ruby + Python + JavaScript
cursor-init ~/proyectos/mi-app

# En directorio actual
cursor-init .

# Con Rails
cursor-init ~/proyectos/mi-rails-app --rails

# Con MCP de GitHub
cursor-init ~/proyectos/mi-app --mcp-github

# Combinar opciones
cursor-init ~/proyectos/mi-app --rails --mcp-github --mcp-postgres
```

## Qué incluye

### Lenguajes (siempre incluidos)

| Lenguaje   | Reglas                                   |
|------------|------------------------------------------|
| Ruby       | Convenciones estilo + documentación YARD |
| Python     | PEP8 + Google-style docstrings           |
| JavaScript | ES6+ moderno + JSDoc                     |

### Opciones adicionales

| Opción           | Descripción                              |
|------------------|------------------------------------------|
| `--rails`        | Convenciones Rails (MVC, seguridad, N+1) |
| `--mcp-github`   | Integración GitHub (issues, PRs, repos)  |
| `--mcp-postgres` | Integración PostgreSQL                   |

### Comandos incluidos

| Comando   | Uso en Cursor  | Descripción                           |
|-----------|----------------|---------------------------------------|
| document  | `/document`    | Documenta código según el lenguaje    |
| review    | `/review`      | Code review por severidad             |

## Estructura generada

```
mi-proyecto/
├── .cursor/
│   ├── rules/
│   │   ├── ruby-style.mdc
│   │   ├── ruby-docs.mdc
│   │   ├── python-style.mdc
│   │   ├── python-docs.mdc
│   │   ├── javascript-style.mdc
│   │   ├── javascript-docs.mdc
│   │   └── rails-rails.mdc          # si --rails
│   ├── commands/
│   │   ├── document.md
│   │   └── review.md
│   └── mcp.json                      # si --mcp-*
└── .cursorignore
```

## Personalización

Los templates están en `templates/`. Puedes:

- Editar reglas existentes
- Añadir nuevos lenguajes
- Crear comandos personalizados
- Añadir configuraciones MCP

Ver [docs/](docs/) para más información.

## Desinstalación

```bash
cd cursor-init
make uninstall
```

---

## cursor-config

Gestiona la configuración global de Cursor IDE.

### Comandos

```bash
cursor-config setup              # Aplica configuración recomendada
cursor-config backup <dir>       # Guarda backup de tu configuración
cursor-config restore <dir>      # Restaura desde backup
cursor-config show               # Muestra configuración actual
cursor-config extensions list    # Lista extensiones instaladas
```

### Setup: Configuración recomendada

`cursor-config setup` aplica:

| Configuración | Valor | Por qué |
|---------------|-------|---------|
| Data Sharing | OFF | Tu código no entrena modelos |
| Index New Folders | OFF | Indexas manualmente cada proyecto |
| Auto-Run Mode | Ask Every Time | Seguro, siempre pregunta antes de ejecutar |
| Web Search Tool | ON | Agent puede buscar en internet |
| File Deletion Protection | ON | Previene borrados accidentales |
| Dotfile Protection | ON | Protege .gitignore, .env, etc. |
| External-File Protection | ON | Protege archivos fuera del proyecto |
| Default Mode | Agent | Agent mode por defecto |

### Backup y Restore

```bash
# Guardar tu configuración
cursor-config backup ~/cursor-backup

# En otro PC, restaurar
cursor-config restore ~/cursor-backup
```

El backup incluye:
- `settings.json` (configuración principal)
- `keybindings.json` (atajos de teclado)
- `snippets/` (snippets personalizados)
- `mcp.json` (MCP global)
- `extensions.txt` (lista de extensiones)

**Nota:** El backup puede contener tokens en `mcp.json`. No lo compartas sin revisarlo.

---

## Licencia

MIT
