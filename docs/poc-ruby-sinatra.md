# POC: API REST con Ruby y Sinatra

**Guía práctica paso a paso usando todas las características de Cursor IDE**

> **Nota:** Esta POC está basada en **Cursor IDE versión 2.2.20**. Algunas características pueden variar en versiones anteriores o posteriores.

---

## Objetivo

Crear una API REST completa para gestionar tareas (TODO), demostrando cómo usar **todas las características de Cursor IDE** en un proyecto real:

- Chat con Agent Mode
- Composer
- Inline Edit (Cmd+K)
- Símbolos @ (@Codebase, @file, @Web, @Docs)
- Commands personalizados
- Rules de proyecto
- MCP (GitHub y PostgreSQL)
- Checkpoints

---

## Requisitos previos

- Ruby 3.x instalado
- Bundler (`gem install bundler`)
- PostgreSQL (opcional, para MCP)
- Cursor IDE configurado con `cursor-config setup`

---

## Paso 1: Crear el proyecto con Agent Mode

Abre una carpeta vacía en Cursor y usa el Chat en modo Agent.

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
Crea un proyecto Ruby con Sinatra para una API REST de tareas (TODO).

Estructura:
- Gemfile con sinatra, sinatra-contrib, puma, json
- config.ru para Rack
- app.rb con la aplicación principal
- Carpeta routes/ para los endpoints
- Carpeta models/ para los modelos
- Carpeta spec/ para tests con RSpec

El modelo Task tiene: id, title, description, completed (boolean), created_at

Endpoints:
- GET /tasks - Lista todas las tareas
- GET /tasks/:id - Obtiene una tarea
- POST /tasks - Crea una tarea
- PUT /tasks/:id - Actualiza una tarea
- DELETE /tasks/:id - Elimina una tarea
- GET /health - Health check

Usa almacenamiento en memoria por ahora (un array).
```

**->** El Agent creará toda la estructura del proyecto.

**Paso 1.1:** Revisa los archivos propuestos en el panel de diferencias.

**Paso 1.2:** Haz clic en "Accept All" para aplicar los cambios.

---

## Paso 2: Inicializar con cursor-init

Ahora añade la configuración de Cursor al proyecto.

**>> Dónde:** Terminal integrada (Ctrl+`)

```bash
cursor-init . --mcp-github
```

**->** Se creará:
```
.cursor/
├── rules/
│   ├── ruby-style.mdc
│   └── ruby-docs.mdc
├── commands/
│   ├── document.md
│   └── review.md
└── mcp.json
.cursorignore
```

---

## Paso 3: Usar @Codebase para entender el proyecto

Verifica que el indexado funciona correctamente.

**>> Dónde:** Chat (Cmd+L)

**Prompt:**
```
@Codebase ¿Cómo está organizado este proyecto? ¿Dónde se definen las rutas?
```

**->** El Agent buscará en todo el proyecto y te explicará la estructura.

---

## Paso 4: Añadir validaciones con Inline Edit

Selecciona el método de crear tarea y mejóralo.

**Paso 4.1:** Abre `routes/tasks.rb` (o donde esté el POST /tasks)

**Paso 4.2:** Selecciona el bloque del endpoint POST

**>> Dónde:** Inline Edit (Cmd+K sobre la selección)

**Prompt:**
```
Añade validación: title es requerido (min 3 caracteres), description es opcional. Devuelve 422 con errores JSON si falla.
```

**->** El código se modifica inline. Revisa y acepta.

---

## Paso 5: Crear tests con Composer

Usa Composer para generar tests de forma dirigida.

**>> Dónde:** Composer (Cmd+I)

**Prompt:**
```
#routes/tasks.rb Genera tests RSpec completos para todos los endpoints de tasks.

Incluye:
- Casos de éxito (200, 201)
- Casos de error (404, 422)
- Validación de JSON response
- Setup y teardown

Guárdalos en spec/routes/tasks_spec.rb
```

**->** Composer crea el archivo de tests. Haz clic en "Create".

---

## Paso 6: Usar @Web para resolver dudas

Si tienes dudas sobre Sinatra, consulta la web.

**>> Dónde:** Chat (Cmd+L)

**Prompt:**
```
@Web ¿Cómo configuro CORS en Sinatra para permitir peticiones desde cualquier origen?
```

**->** El Agent busca en internet y te da la solución actualizada.

---

## Paso 7: Aplicar el Command /review

Usa el comando de code review incluido en cursor-init.

**Paso 7.1:** Abre `app.rb`

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
/review @app.rb
```

**->** El Agent ejecuta el code review siguiendo el template:
- Seguridad
- Performance
- Legibilidad
- Tests

Presenta hallazgos por severidad: CRÍTICO > ALTO > MEDIO > BAJO

---

## Paso 8: Documentar con /document

Genera documentación YARD automáticamente.

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
/document @models/task.rb
```

**->** El Agent añade documentación YARD al modelo:

```ruby
# Representa una tarea en el sistema
#
# @attr [Integer] id Identificador único
# @attr [String] title Título de la tarea (requerido)
# @attr [String] description Descripción opcional
# @attr [Boolean] completed Estado de completitud
# @attr [Time] created_at Fecha de creación
class Task
  # ...
end
```

---

## Paso 9: Usar @Docs con documentación externa

Añade la documentación de Sinatra a Cursor.

**Paso 9.1:** Añadir documentación

**>> Dónde:** Chat (Cmd+L)

Escribe `@Docs` → selecciona "Add new doc" → pega:
```
https://sinatrarb.com/documentation.html
```

**Paso 9.2:** Usar la documentación

**>> Dónde:** Chat (Cmd+L)

**Prompt:**
```
@Docs Sinatra ¿Cómo añado middleware para logging de requests? Muéstrame un ejemplo.
```

**->** El Agent busca en la documentación indexada de Sinatra.

---

## Paso 10: Debugging con @file específico

Si hay un bug, referencia el archivo exacto.

**>> Dónde:** Chat (Cmd+L)

**Prompt:**
```
@routes/tasks.rb El endpoint DELETE devuelve 200 aunque el task no exista. ¿Por qué? Corrígelo para que devuelva 404.
```

**->** El Agent analiza el archivo específico, encuentra el bug, y propone el fix.

---

## Paso 11: Refactoring con modo Ask primero

Antes de un refactor grande, analiza sin modificar.

**Paso 11.1:** Cambiar a modo Ask

**>> Dónde:** Chat (Cmd+L) → Modo Ask (dropdown)

**Prompt:**
```
@Codebase Quiero extraer la lógica de validación a un módulo separado. ¿Qué archivos tendría que modificar? ¿Qué riesgos hay?
```

**->** El Agent analiza sin modificar nada.

**Paso 11.2:** Ejecutar el refactor

Cambia a modo Agent y ejecuta:

**Prompt:**
```
Ejecuta el refactor: crea lib/validators/task_validator.rb y úsalo en routes/tasks.rb. Después ejecuta los tests.
```

---

## Paso 12: Usar MCP de GitHub

Si configuraste `--mcp-github`, puedes interactuar con GitHub.

**Paso 12.1:** Crear el repositorio

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
Usa el MCP de GitHub para crear un repositorio privado llamado 'sinatra-tasks-api' con descripción 'API REST de tareas con Sinatra'.
```

**Paso 12.2:** Crear issues para mejoras

**Prompt:**
```
Crea 3 issues en GitHub:
1. "Añadir persistencia con PostgreSQL" - Reemplazar almacenamiento en memoria
2. "Implementar autenticación JWT" - Proteger endpoints
3. "Añadir paginación" - Para GET /tasks
```

**Paso 12.3:** Crear PR

Después de hacer cambios:

**Prompt:**
```
He terminado la feature de validaciones. Crea un PR con título descriptivo y lista los cambios realizados.
```

---

## Paso 13: Usar Checkpoints

Si algo sale mal, restaura un estado anterior.

**Paso 13.1:** El Agent hace un cambio que rompe algo

**Paso 13.2:** En el panel de Chat, busca el historial

**Paso 13.3:** Haz clic en "Restore Checkpoint" en el punto anterior al error

**->** Los archivos vuelven al estado anterior.

> **Importante:** Los checkpoints son de sesión. Para historial permanente, usa Git.

---

## Paso 14: Añadir persistencia con PostgreSQL y MCP

Si tienes MCP de PostgreSQL configurado.

**Paso 14.1:** Configura la conexión

Edita `.cursor/mcp.json`:
```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "POSTGRES_URL": "postgresql://user:pass@localhost:5432/tasks_dev"
      }
    }
  }
}
```

**Paso 14.2:** Crea la tabla

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
Usa el MCP de PostgreSQL para crear la tabla tasks:
- id SERIAL PRIMARY KEY
- title VARCHAR(255) NOT NULL
- description TEXT
- completed BOOLEAN DEFAULT false
- created_at TIMESTAMP DEFAULT NOW()
```

**Paso 14.3:** Migra el código

**Prompt:**
```
@Codebase Migra el almacenamiento de memoria a PostgreSQL. Usa la gema 'pg'. Actualiza el modelo Task y todos los endpoints.
```

---

## Paso 15: TDD - Añadir nueva feature

Practica TDD con el Agent.

**Paso 15.1:** Escribe tests primero

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
Escribe tests RSpec para una nueva feature: filtrar tareas.

GET /tasks?completed=true → solo tareas completadas
GET /tasks?completed=false → solo tareas pendientes
GET /tasks?q=texto → buscar en title y description

NO implementes la feature, solo los tests.
```

**Paso 15.2:** Implementa hasta que pasen

**Prompt:**
```
Implementa los filtros en GET /tasks para que pasen los tests. Ejecuta 'bundle exec rspec' después de cada cambio.
```

---

## Resumen: Características de Cursor usadas

| Característica | Dónde se usó |
|----------------|--------------|
| Agent Mode | Crear proyecto, implementar features |
| Composer | Generar tests dirigidos |
| Inline Edit (Cmd+K) | Añadir validaciones |
| @Codebase | Entender estructura, buscar código |
| @file | Debugging específico |
| @Web | Resolver dudas con internet |
| @Docs | Documentación de Sinatra |
| /review | Code review del proyecto |
| /document | Documentación YARD |
| Rules | Aplicadas automáticamente (ruby-style.mdc) |
| MCP GitHub | Crear repo, issues, PRs |
| MCP PostgreSQL | Crear tablas, queries |
| Checkpoints | Restaurar estado anterior |
| Modo Ask | Análisis antes de refactor |

---

## Estructura final del proyecto

```
sinatra-tasks-api/
├── .cursor/
│   ├── rules/
│   │   ├── ruby-style.mdc
│   │   └── ruby-docs.mdc
│   ├── commands/
│   │   ├── document.md
│   │   └── review.md
│   └── mcp.json
├── .cursorignore
├── Gemfile
├── Gemfile.lock
├── config.ru
├── app.rb
├── lib/
│   └── validators/
│       └── task_validator.rb
├── models/
│   └── task.rb
├── routes/
│   └── tasks.rb
└── spec/
    ├── spec_helper.rb
    └── routes/
        └── tasks_spec.rb
```

---

## Próximos pasos

1. **Autenticación:** Añadir JWT con la gema `jwt`
2. **Rate limiting:** Usar `rack-attack`
3. **Documentación API:** Generar con Swagger/OpenAPI
4. **Docker:** Containerizar la aplicación
5. **CI/CD:** Configurar GitHub Actions

---

**— Fin de la POC —**
