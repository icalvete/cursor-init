# Cursor IDE: Conceptos Avanzados

**Agent Mode, MCP, Commands y optimización — Diciembre 2025**

> **Nota:** Este tutorial está basado en **Cursor IDE versión 2.2.20**. Algunas características pueden variar en versiones anteriores o posteriores.

---

**Prerequisito:** Tutorial Básico de Cursor IDE

## Leyenda de este documento

- **Paso N:** Instrucción paso a paso
- **>> Dónde:** Indica en qué interfaz ejecutar (Chat, Composer, etc.)
- **Prompt:** Texto a escribir
- **->** Resultado esperado

---

## 1. Agent Mode

Agent Mode es el modo más autónomo de Cursor. A diferencia del Chat básico, el Agent puede explorar tu codebase, ejecutar comandos de terminal, crear y modificar múltiples archivos.

### 1.1 Cómo acceder a Agent Mode

1. **Paso 1:** Presiona `Cmd+L` (Mac) o `Ctrl+L` (Windows) para abrir el Chat
2. **Paso 2:** En la parte inferior del panel de Chat, verás un dropdown con modos
3. **Paso 3:** Selecciona 'Agent' en el dropdown (puede estar ya seleccionado por defecto)
4. **Paso 4:** El indicador cambiará a 'Agent' confirmando el modo activo

> **TIP:** Desde la versión 0.46 (febrero 2025), Agent es el modo por defecto al abrir Chat.

### 1.2 Tu primer prompt en Agent Mode

Vamos a hacer un ejemplo completo paso a paso:

1. **Paso 1:** Abre un proyecto en Cursor (File → Open Folder)
2. **Paso 2:** Presiona `Cmd+L` para abrir Chat
3. **Paso 3:** Verifica que el modo sea 'Agent' (dropdown inferior)
4. **Paso 4:** Escribe el siguiente prompt:

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
Analiza la estructura de este proyecto. ¿Qué tecnologías usa? ¿Cómo está organizado?
```

5. **Paso 5:** Presiona Enter o el botón de enviar

**->** El Agent explorará los archivos, leerá package.json, tsconfig, etc. y te dará un resumen.

### 1.3 Ejemplo práctico: Añadir una feature

Veamos cómo el Agent puede implementar una feature completa:

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
Añade un endpoint GET /api/health que devuelva { status: 'ok', timestamp: Date.now() }. Debe estar en el archivo de rutas existente.
```

El Agent hará lo siguiente automáticamente:
1. Buscará el archivo de rutas en tu proyecto
2. Analizará la estructura existente
3. Añadirá el nuevo endpoint siguiendo el mismo estilo
4. Te mostrará los cambios propuestos

6. **Paso 6:** Revisa los cambios en el panel de diferencias
7. **Paso 7:** Haz clic en 'Accept' para aplicar o 'Reject' para descartar

### 1.4 Modos disponibles

| Modo | Cómo activar | Qué hace |
|------|--------------|----------|
| Agent | Dropdown → Agent | Autónomo, usa todas las herramientas |
| Ask | Dropdown → Ask | Solo lectura, no modifica nada |
| Manual/Edit | Dropdown → Edit | Solo hace lo que pides explícitamente |

### 1.5 YOLO Mode (ejecución automática)

YOLO Mode permite al Agent ejecutar comandos de terminal sin pedir confirmación:

1. **Paso 1:** Ve a Cursor Settings (`Cmd+,` → busca 'Cursor Settings')
2. **Paso 2:** Navega a Features → Agent
3. **Paso 3:** Activa 'Auto-run commands' o 'YOLO Mode'
4. **Paso 4:** Configura allow/deny lists si quieres restringir comandos

> **AVISO:** Con YOLO activo, el Agent ejecutará npm install, tests, etc. automáticamente. Revisa los cambios con cuidado.

---

## 2. Model Context Protocol (MCP)

MCP permite conectar Cursor con herramientas externas: bases de datos, GitHub, Slack, etc.

### 2.1 Configurar MCP Server (método un click)

1. **Paso 1:** Abre Cursor Settings: `Cmd+Shift+P` → 'Cursor Settings'
2. **Paso 2:** En el panel izquierdo, haz clic en 'MCP'
3. **Paso 3:** Haz clic en 'Browse Servers' o '+ Add Server'
4. **Paso 4:** Busca el server que quieres (ej: 'GitHub')
5. **Paso 5:** Haz clic en 'Install' o 'Add'
6. **Paso 6:** Si pide autenticación (OAuth), sigue el flujo en el navegador
7. **Paso 7:** Espera a que el indicador se ponga verde (conectado)

### 2.2 Configurar MCP Server (método manual)

Para servers no disponibles en el catálogo, o para personalizar:

**Paso 1:** Crea el archivo de configuración:

```bash
# Para este proyecto solamente:
mkdir -p .cursor
touch .cursor/mcp.json

# O para todos tus proyectos:
touch ~/.cursor/mcp.json
```

**Paso 2:** Añade la configuración del server:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "ghp_tu_token_aqui"
      }
    }
  }
}
```

**Paso 3:** Guarda el archivo

**Paso 4:** En Cursor Settings → MCP, haz clic en 'Refresh'

**Paso 5:** El server debe aparecer con indicador verde

### 2.3 Usando MCP con GitHub: Ejemplos prácticos

Una vez configurado el MCP de GitHub, puedes hacer lo siguiente:

#### Ejemplo 1: Listar Issues abiertos

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
Usa el MCP de GitHub para listar los issues abiertos en este repositorio. Muestra título, número y etiquetas.
```

**->** El Agent llama a la herramienta list_issues del MCP y te muestra una lista formateada.

#### Ejemplo 2: Crear un Issue

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
Crea un issue en GitHub con título 'Bug: Login falla con emails con +' y descripción detallando que el regex de validación no acepta el carácter +.
```

**->** El Agent usa create_issue del MCP. Te pedirá confirmación antes de crearlo.

#### Ejemplo 3: Revisar un PR

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
Revisa el PR #42. Analiza los cambios, busca posibles bugs, y sugiere mejoras.
```

**->** El Agent obtiene el diff del PR via MCP, lo analiza, y te da feedback.

#### Ejemplo 4: Buscar en el historial

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
¿Cuándo se introdujo la función validateEmail? Busca en el historial de commits.
```

**->** El Agent busca en commits y te muestra cuándo y quién añadió esa función.

#### Ejemplo 5: Crear PR desde cambios locales

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
He terminado el feature de reset password. Crea un PR con título descriptivo y descripción detallada de los cambios.
```

**->** El Agent analiza tus cambios, genera descripción, y crea el PR via MCP.

### 2.4 Otros MCP Servers útiles

| Server | Para qué | Ejemplo de uso |
|--------|----------|----------------|
| PostgreSQL | Queries a tu BD | "Muéstrame los usuarios creados hoy" |
| Elasticsearch | Buscar en logs | "Busca errores 500 de las últimas 2h" |
| Slack | Enviar mensajes | "Envía resumen del PR al canal #dev" |
| Puppeteer | Controlar browser | "Haz screenshot de la página de login" |

---

## 3. Commands (Reemplazo de Notepads)

> **AVISO:** Notepads fue deprecado en octubre 2025. Usa Commands en su lugar.

### 3.1 Crear un Command

**Paso 1:** Crea la carpeta de commands en tu proyecto:
```bash
mkdir -p .cursor/commands
```

**Paso 2:** Crea un archivo .md para tu command:
```bash
touch .cursor/commands/code-review.md
```

**Paso 3:** Añade el contenido del command:
```markdown
# Code Review Checklist

Revisa el código seleccionado:

1. **Seguridad**: SQL injection, XSS, secrets expuestos
2. **Performance**: N+1 queries, loops innecesarios
3. **Legibilidad**: Nombres claros, funciones cortas
4. **Tests**: ¿Hay tests? ¿Cubren edge cases?

Presenta hallazgos por severidad: CRÍTICO > ALTO > MEDIO
```

**Paso 4:** Guarda el archivo

### 3.2 Usar un Command

1. **Paso 1:** Selecciona código en el editor (opcional)
2. **Paso 2:** Abre Chat: `Cmd+L`
3. **Paso 3:** Escribe `/` y verás la lista de commands disponibles
4. **Paso 4:** Selecciona tu command o escríbelo:

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
/code-review
```

**->** El contenido del command se inyecta y el Agent ejecuta la revisión.

---

## 4. Custom Docs (@Docs)

Cursor tiene documentación pre-indexada de librerías populares. Puedes añadir más.

### 4.1 Añadir documentación nueva

1. **Paso 1:** Abre Chat: `Cmd+L`
2. **Paso 2:** Escribe `@Docs` y presiona espacio
3. **Paso 3:** En el menú que aparece, selecciona 'Add new doc'
4. **Paso 4:** Pega la URL de la documentación:
   ```
   https://docs.pydantic.dev/latest/
   ```

> **TIP:** Añade `/` al final de la URL para que indexe todas las subpáginas.

5. **Paso 5:** Presiona Enter
6. **Paso 6:** Espera a que Cursor indexe (puede tardar 1-5 minutos)

**->** Verás un mensaje de confirmación cuando termine.

### 4.2 Gestionar documentación añadida

1. **Paso 1:** Abre Cursor Settings: `Cmd+Shift+P` → 'Cursor Settings'
2. **Paso 2:** Navega a Features → Docs
3. **Paso 3:** Verás lista de docs añadidos
4. **Paso 4:** Puedes editar, eliminar, o añadir más desde aquí

### 4.3 Usar @Docs: Ejemplos

#### Ejemplo 1: Validación con Pydantic

Después de añadir la documentación de Pydantic:

**>> Dónde:** Chat (Cmd+L)

**Prompt:**
```
@Docs Pydantic ¿Cómo valido un campo email que no puede estar vacío? Muéstrame un modelo completo.
```

**->** El Agent busca en la documentación indexada y te da código específico de Pydantic.

#### Ejemplo 2: AWS CDK

Después de añadir `https://docs.aws.amazon.com/cdk/v2/guide/`:

**>> Dónde:** Chat (Cmd+L)

**Prompt:**
```
@Docs AWS CDK ¿Cómo creo un bucket S3 con versionado y lifecycle rules? TypeScript.
```

#### Ejemplo 3: Combinar @Docs con código local

**>> Dónde:** Chat (Cmd+L)

**Prompt:**
```
@Docs Prisma @src/prisma/schema.prisma Añade soft delete a todos los modelos siguiendo las mejores prácticas de Prisma.
```

**->** El Agent lee tu schema actual Y la documentación de Prisma para darte la mejor solución.

---

## 5. Optimización y .cursorignore

### 5.1 Crear .cursorignore

**Paso 1:** En la raíz de tu proyecto, crea el archivo:
```bash
touch .cursorignore
```

**Paso 2:** Añade patrones de archivos a ignorar:
```gitignore
# Dependencias
node_modules/
venv/

# Build
dist/
build/

# Sensibles
.env
.env.*
*.pem

# Datos grandes
*.csv
data/raw/
```

**Paso 3:** Guarda el archivo

**->** Cursor excluirá estos archivos del indexado y del contexto de la IA.

---

## 6. Cursor Agent CLI

### 6.1 Instalación

**Paso 1:** Abre tu terminal (fuera de Cursor)

**Paso 2:** Ejecuta el instalador:
```bash
curl https://cursor.com/install -fsSL | bash
```

**Paso 3:** Verifica la instalación:
```bash
cursor-agent --version
```

### 6.2 Uso del CLI

> **IMPORTANTE:** El CLI necesita estar en un directorio de proyecto para tener contexto.

**Paso 1:** Navega a tu proyecto:
```bash
cd /ruta/a/mi-proyecto
```

**Paso 2:** Ejecuta el agente:

**Modo interactivo (conversacional):**
```bash
cursor-agent chat
```
**->** Se abre un chat en la terminal. Escribe prompts y recibe respuestas.

**Modo con prompt directo:**
```bash
cursor-agent chat "encuentra bugs en src/auth.js y corrígelos"
```
**->** Ejecuta el prompt y muestra el resultado.

**Modo no interactivo (para scripts):**
```bash
cursor-agent -p "añade tests a utils.js" --output-format json
```
**->** Output en JSON, útil para pipelines CI/CD.

---

## 7. Gestión de Contexto

### 7.1 Síntomas de contexto degradado

Reconoce cuándo necesitas actuar:
- El Agent 'olvida' lo que hablaron antes en la misma conversación
- Da respuestas genéricas ignorando tu código específico
- Repite errores que ya habías corregido
- Confunde nombres de archivos o funciones

### 7.2 Solución 1: Usar /summarize

**>> Dónde:** Chat (Cmd+L) - en conversación existente

**Paso 1:** Cuando la conversación sea muy larga (20+ mensajes), escribe:

**Prompt:**
```
/summarize
```

**Paso 2:** El Agent comprime el historial manteniendo lo esencial

**Paso 3:** Continúa la conversación normalmente

### 7.3 Solución 2: Nueva conversación con contexto

**Paso 1:** Inicia nueva conversación: `Cmd+L`, luego clic en '+' o 'New Chat'

**Paso 2:** En el primer mensaje, incluye el contexto necesario:

**>> Dónde:** Chat (Cmd+L) → Nueva conversación

**Prompt:**
```
Estoy trabajando en @src/services/auth.js. Ya implementé login con JWT (funciona). Ahora necesito añadir refresh tokens. El middleware está en @src/middleware/auth.js.
```

**->** El Agent tiene contexto limpio y específico para continuar.

### 7.4 Solución 3: Re-anclar con @filename

Si el Agent perdió el hilo de un archivo:

**>> Dónde:** Chat (Cmd+L)

**Prompt:**
```
@src/api/users.js Mira de nuevo este archivo. La función createUser en línea 45 necesita validación de email.
```

### 7.5 Cuándo iniciar nueva conversación

- Cambias de tarea/feature completamente
- Han pasado 20-30+ mensajes
- Las respuestas se vuelven genéricas o incorrectas
- Terminaste una tarea y empiezas otra diferente

---

## 8. Workflows Avanzados

### 8.1 Test-Driven Development (TDD)

TDD con Agent es muy efectivo porque los tests son especificación verificable.

#### Fase 1: Escribir tests primero

1. **Paso 1:** Abre Chat: `Cmd+L` (modo Agent)
2. **Paso 2:** Pide tests basados en requisitos:

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
Escribe tests para un servicio CartService con estos requisitos:
- addItem(productId, quantity): añade al carrito
- getTotal(): suma precios con 21% IVA
- applyDiscount(code): aplica descuento
- clear(): vacía el carrito

Usa vitest. NO implementes el servicio, solo tests.
```

3. **Paso 3:** Revisa los tests generados
4. **Paso 4:** Acepta los cambios

#### Fase 2: Verificar tests

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
Añade estos tests adicionales:
- addItem con quantity 0 debe fallar
- applyDiscount con código expirado debe fallar
- getTotal con carrito vacío devuelve 0
```

#### Fase 3: Implementar hasta que pasen

1. **Paso 1:** Asegúrate de tener YOLO mode activo (Settings → Agent)
2. **Paso 2:** Pide la implementación:

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
Implementa CartService para que pasen todos los tests. Ejecuta 'npm test' después de cada cambio y continúa hasta que todos pasen.
```

**->** El Agent implementa, ejecuta tests, ve errores, corrige, repite hasta que todo pasa.

#### Fase 4: Code review

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
/code-review @src/services/CartService.ts
```

### 8.2 Refactoring a gran escala

#### Preparación

**Paso 1:** Haz commit del estado actual:
```bash
git add .
git commit -m "before refactoring"
```

**Paso 2:** Verifica que tests pasen:
```bash
npm test
```

#### Fase 1: Análisis (modo Ask)

1. **Paso 1:** Cambia a modo Ask (dropdown del Chat)
2. **Paso 2:** Analiza el impacto:

**>> Dónde:** Chat (Cmd+L) → Modo Ask

**Prompt:**
```
@Codebase Quiero migrar de callbacks a async/await en todo el proyecto. ¿Qué archivos usan callbacks? ¿Cuáles tienen más dependencias? ¿Qué riesgos hay?
```

**->** El Agent analiza sin modificar nada y te da un informe.

#### Fase 2: Plan de migración

**>> Dónde:** Chat (Cmd+L) → Modo Ask

**Prompt:**
```
Crea un plan de migración en fases. Cada fase debe ser un commit independiente. Empieza por archivos con menos dependencias.
```

#### Fase 3: Ejecutar fase por fase

1. **Paso 1:** Cambia a modo Agent
2. **Paso 2:** Ejecuta la primera fase:

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
Ejecuta la Fase 1: migrar src/utils/helpers.js a async/await. Después ejecuta npm test.
```

3. **Paso 3:** Si tests pasan, haz commit:
```bash
git add .
git commit -m "refactor: migrate helpers to async/await"
```

4. **Paso 4:** Repite para cada fase

### 8.3 Debugging con MCP

Combina Agent con MCP para debugging con datos reales.

#### Ejemplo: Bug de datos duplicados

**Requisito:** MCP de PostgreSQL configurado.

**Paso 1:** Describe el síntoma:

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
Tengo pedidos duplicados en el reporte. Usa el MCP de PostgreSQL para:
1. Buscar duplicados: SELECT order_number, COUNT(*) FROM orders GROUP BY order_number HAVING COUNT(*) > 1
2. Muéstrame los resultados
```

**Paso 2:** Con los datos, pide análisis del código:

**Prompt:**
```
Encontraste 15 order_numbers duplicados. Ahora revisa @src/services/orderService.js y encuentra por qué se crean duplicados.
```

**Paso 3:** Aplica el fix:

**Prompt:**
```
Implementa el fix usando transacciones para evitar race conditions.
```

#### Ejemplo: Debugging de logs

**Requisito:** MCP de Elasticsearch configurado.

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
El endpoint /api/checkout falla con 500 intermitentemente. Usa Elasticsearch para:
1. Buscar logs con path=/api/checkout y status=500
2. Últimas 24 horas
3. Agrupa por hora y muéstrame el patrón
```

**->** El Agent ejecuta queries en ES, identifica patrones, y puede correlacionar con el código.

---

## 9. Recursos

### Documentación oficial

- [docs.cursor.com](https://docs.cursor.com)
- [cursor.com/changelog](https://cursor.com/changelog)

### MCP

- [github.com/cursor/mcp-servers](https://github.com/cursor/mcp-servers)
- [smithery.ai](https://smithery.ai)

---

**— Fin del Tutorial Avanzado —**
