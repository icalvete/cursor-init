# Code Review

Revisa el código seleccionado:

## 1. Seguridad
- Inyección SQL, XSS, CSRF
- Secrets hardcodeados
- Validación de input

## 2. Rendimiento
- N+1 queries
- Loops ineficientes
- Memory leaks

## 3. Legibilidad
- Nombres descriptivos
- Funciones cortas (< 20 líneas)
- Código duplicado

## 4. Robustez
- Manejo de errores
- Edge cases
- Null checks

## Severidad

- **CRÍTICO**: Seguridad, pérdida de datos. Arreglar antes de merge.
- **ALTO**: Bugs potenciales, performance. Arreglar pronto.
- **MEDIO**: Legibilidad, refactoring. Cuando sea posible.
- **BAJO**: Sugerencias menores.
