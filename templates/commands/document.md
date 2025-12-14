# Documentar código

Documenta el código seleccionado usando el formato estándar del lenguaje:

- **Ruby**: YARD (`@param`, `@return`, `@example`)
- **Python**: Google-style docstrings (Args, Returns, Raises)
- **JavaScript/TypeScript**: JSDoc (`@param`, `@returns`, `@example`)
- **Otros**: Formato idiomático del lenguaje

## Qué incluir

1. **Descripción**: Qué hace (no cómo). Breve en primera línea.
2. **Parámetros**: Tipo y descripción. Indica opcionales y defaults.
3. **Retorno**: Qué devuelve y tipo.
4. **Excepciones**: Qué errores puede lanzar.
5. **Ejemplo**: Si el uso no es obvio.

## Criterios

- Documenta funciones/métodos públicos
- Para privados simples, una línea basta
- Evita lo obvio: `@param name The name` no aporta nada
