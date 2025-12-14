# Tutorial Cursor IDE

**Guía completa para desarrollo asistido por IA — Diciembre 2025**

> **Nota:** Este tutorial está basado en **Cursor IDE versión 2.2.20**. Algunas características pueden variar en versiones anteriores o posteriores.

---

## Leyenda de este documento

- **Paso N:** Instrucción paso a paso
- **>> Dónde:** En qué interfaz ejecutar
- **Prompt:** Texto a escribir
- **->** Resultado esperado

---

## 1. ¿Qué es Cursor IDE?

Cursor es un editor de código basado en VS Code con inteligencia artificial integrada de forma nativa. La IA está en el core del editor, no es un plugin.

### 1.1 Ventajas sobre VS Code + Copilot

- **Contexto completo:** Ve todo tu proyecto, no solo el archivo actual
- **Agent mode:** Ejecuta comandos, crea archivos, cambios multi-archivo
- **Búsqueda semántica:** @Codebase entiende tu código
- **Reglas personalizables:** Define comportamiento por proyecto
- **Checkpoints:** Restauración automática antes de cada cambio

---

## 2. Instalación y Configuración

### 2.1 Instalar Cursor

1. **Paso 1:** Ve a [cursor.com](https://cursor.com) en tu navegador
2. **Paso 2:** Haz clic en Download
3. **Paso 3:** Ejecuta el instalador descargado
4. **Paso 4:** En el primer inicio, te preguntará si importar configuración de VS Code
5. **Paso 5:** Crea una cuenta o inicia sesión (necesario para usar los modelos)

### 2.2 Configuración recomendada

1. **Paso 1:** Abre Cursor Settings: `Cmd+Shift+P` (Mac) o `Ctrl+Shift+P` (Win)
2. **Paso 2:** Escribe 'Cursor Settings' y selecciona la opción
3. **Paso 3:** En Features, activa:
   - **Codebase Indexing:** ON (permite @Codebase)
   - **Agent auto-run:** Según tu preferencia

---

## 3. Las Tres Interfaces de IA

Cursor tiene tres formas de interactuar con la IA. Es importante saber cuál usar:

| Interfaz | Atajo | Para qué | Modifica archivos |
|----------|-------|----------|-------------------|
| Chat | Cmd+L / Ctrl+L | Preguntas, análisis, tareas complejas | Sí (modo Agent) |
| Composer | Cmd+I / Ctrl+I | Crear/editar archivos específicos | Sí |
| Inline Edit | Cmd+K / Ctrl+K | Editar código seleccionado | Sí |

### 3.1 Chat (Cmd+L)

Panel lateral para conversaciones. Usa este para:
- Preguntas sobre el código
- Tareas que requieren análisis
- Implementar features completas (modo Agent)

**Pasos:**
1. Presiona `Cmd+L` (Mac) o `Ctrl+L` (Windows)
2. Se abre el panel de Chat a la derecha
3. Escribe tu pregunta o instrucción
4. Presiona Enter para enviar

### 3.2 Composer (Cmd+I)

Ventana flotante o panel para crear/editar archivos. Usa este para:
- Crear archivos nuevos desde cero
- Editar un archivo específico
- Cambios que conoces bien

**Pasos:**
1. Presiona `Cmd+I` (Mac) o `Ctrl+I` (Windows)
2. Se abre una ventana flotante (o `Cmd+Shift+I` para panel completo)
3. Escribe qué quieres crear o modificar
4. Usa `#filename` para referenciar archivos específicos

### 3.3 Inline Edit (Cmd+K)

Edición directa en el código. Usa este para:
- Refactorizar código seleccionado
- Añadir tipos TypeScript
- Cambios rápidos y puntuales

**Pasos:**
1. Selecciona código en el editor
2. Presiona `Cmd+K` (Mac) o `Ctrl+K` (Windows)
3. Aparece un input sobre el código seleccionado
4. Escribe qué cambio quieres
5. Presiona Enter

---

## 4. Ejemplos Prácticos

### 4.1 Entender código existente

**>> Dónde:** Chat (Cmd+L)

**Prompt:**
```
¿Qué hace esta función? @src/utils/parser.js
```

**->** El Chat analiza el archivo y explica qué hace cada parte.

### 4.2 Crear un componente nuevo

**>> Dónde:** Composer (Cmd+I)

**Prompt:**
```
Crea un componente React llamado UserCard que muestre avatar, nombre y email. Usa TypeScript y Tailwind.
```

**->** Composer crea el archivo y te muestra el código. Haz clic en 'Create' para guardarlo.

### 4.3 Refactorizar código

1. **Paso 1:** Selecciona el código a refactorizar en el editor

**>> Dónde:** Inline Edit (Cmd+K sobre selección)

**Prompt:**
```
Convierte a async/await
```

**->** El código se transforma inline. Acepta o rechaza el cambio.

### 4.4 Añadir a archivo existente

**>> Dónde:** Chat (Cmd+L) con modo Agent

**Prompt:**
```
@src/routes/users.js Añade un endpoint DELETE /users/:id con validación
```

**->** El Agent modifica el archivo existente añadiendo el nuevo endpoint.

### 4.5 Debugging

**>> Dónde:** Chat (Cmd+L)

**Prompt:**
```
Este código da error 'Cannot read property of undefined'. ¿Por qué? @src/api/handler.js
```

**->** El Chat analiza el código, identifica el problema, y sugiere la solución.

---

## 5. Símbolos @ para Contexto

Los símbolos @ incluyen información específica en tu prompt. Son case-insensitive.

### 5.1 @filename

Incluye el contenido de un archivo:

**>> Dónde:** Chat (Cmd+L) o Composer (Cmd+I)

**Prompt:**
```
@src/models/User.js ¿Este modelo tiene validación de email?
```

### 5.2 @Codebase

Busca en todo el proyecto por significado (semántico):

**>> Dónde:** Chat (Cmd+L)

**Prompt:**
```
@Codebase ¿Dónde se manejan los errores de autenticación?
```

> **TIP:** @Codebase es ideal cuando no sabes en qué archivo está algo.

### 5.3 @Web

Busca información en internet:

**>> Dónde:** Chat (Cmd+L)

**Prompt:**
```
@Web ¿Cuál es la última versión de React y qué novedades tiene?
```

### 5.4 @Docs

Accede a documentación de librerías:

**>> Dónde:** Chat (Cmd+L)

**Prompt:**
```
@Docs React ¿Cómo uso useEffect con cleanup function?
```

### 5.5 @Git

Accede al historial de Git:

**>> Dónde:** Chat (Cmd+L)

**Prompt:**
```
@Git ¿Qué cambios se hicieron en el último commit?
```

### 5.6 #filename (solo en Composer)

En Composer, usa # para editar archivos específicos:

**>> Dónde:** Composer (Cmd+I)

**Prompt:**
```
#src/api/users.js #src/api/auth.js Añade logging a ambos archivos
```

---

## 6. Sistema de Reglas

Las reglas son instrucciones persistentes que no tienes que repetir en cada prompt.

### 6.1 Crear una regla de proyecto

**Paso 1:** Crea la carpeta de reglas:
```bash
mkdir -p .cursor/rules
```

**Paso 2:** Crea un archivo de regla:
```bash
touch .cursor/rules/general.mdc
```

**Paso 3:** Añade el contenido:
```yaml
---
description: Estándares generales del proyecto
alwaysApply: true
---

# Estándares de código

- Usa TypeScript estricto
- Prefiere async/await sobre callbacks
- Funciones pequeñas (< 30 líneas)
- Siempre maneja errores
```

**->** La regla se aplicará automáticamente a todas las conversaciones.

### 6.2 Tipos de reglas

| Tipo | Frontmatter | Cuándo se aplica |
|------|-------------|------------------|
| Always | `alwaysApply: true` | Siempre, automático |
| Auto Attached | `globs: ["*.ts"]` | Si tocas archivos que coinciden |
| Manual | Solo `description` | Cuando escribes @rulename |

---

## 7. Checkpoints

Los checkpoints son snapshots automáticos antes de cada cambio.

### 7.1 Usar checkpoints

Si algo sale mal después de que el Agent hizo cambios:

1. **Paso 1:** En el panel de Chat, busca el historial de cambios
2. **Paso 2:** Haz clic en 'Restore Checkpoint' junto al punto deseado
3. **Paso 3:** Los archivos vuelven al estado anterior

> **AVISO:** Checkpoints son para la sesión actual. Para historial permanente, usa Git.

---

## 8. Proyecto Práctico: API REST

### 8.1 Setup inicial

1. **Paso 1:** Crea una carpeta para el proyecto y ábrela en Cursor
2. **Paso 2:** Abre Chat: `Cmd+L`

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
Inicializa un proyecto Node.js con Express y TypeScript. Incluye: estructura de carpetas, tsconfig.json, package.json con scripts de dev y build, y un endpoint GET /health.
```

3. **Paso 3:** Revisa los archivos creados
4. **Paso 4:** Haz clic en 'Accept All' para aplicar

### 8.2 Crear modelo

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
Crea un modelo User con: id, email, name, createdAt. Usa TypeScript interfaces. Guárdalo en src/models/User.ts
```

### 8.3 Crear endpoints CRUD

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
@src/models/User.ts Crea endpoints CRUD para usuarios en src/routes/users.ts: GET all, GET by id, POST create, PUT update, DELETE. Incluye validación básica.
```

### 8.4 Añadir tests

**>> Dónde:** Chat (Cmd+L) → Modo Agent

**Prompt:**
```
@src/routes/users.ts Genera tests con Jest para todos los endpoints. Incluye casos de éxito y error. Guárdalos en src/__tests__/users.test.ts
```

---

## 9. Mejores Prácticas

### 9.1 Elegir la interfaz correcta

| Quieres... | Usa | Atajo |
|------------|-----|-------|
| Entender código | Chat | Cmd+L |
| Implementar feature completa | Chat (Agent) | Cmd+L |
| Crear archivo nuevo | Composer | Cmd+I |
| Refactorizar selección | Inline | Cmd+K |
| Editar archivo específico | Composer + #file | Cmd+I |

### 9.2 Escribir buenos prompts

- **Sé específico:** di QUÉ quieres, no CÓMO hacerlo
- **Da contexto:** usa @filename para archivos relevantes
- **Divide tareas grandes** en pasos pequeños

### 9.3 Errores comunes

- No dar contexto suficiente (olvidas mencionar archivos)
- Prompts vagos ('mejora este código')
- Aceptar cambios sin revisar
- Conversaciones muy largas (el contexto se degrada)

### 9.4 Cuándo empezar nueva conversación

- Cambias de tarea completamente
- Han pasado 20-30+ mensajes
- Las respuestas se vuelven incorrectas o genéricas

---

## 10. Recursos

- **Documentación:** [docs.cursor.com](https://docs.cursor.com)
- **Changelog:** [cursor.com/changelog](https://cursor.com/changelog)
- **Ejemplos de reglas:** [cursor.directory](https://cursor.directory)

---

**Siguiente paso:** Tutorial 'Cursor IDE: Conceptos Avanzados' con Agent Mode, MCP, y más.

---

**— Fin del Tutorial Básico —**
