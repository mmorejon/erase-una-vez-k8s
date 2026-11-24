@AGENTS.md

## Claude Code

Además de las instrucciones de `AGENTS.md`, en Claude Code el lector tiene estos comandos:

| Comando | Para qué sirve | Ejemplo |
|---------|----------------|---------|
| `/estudiar <capítulo>` | Recorre un capítulo paso a paso | `/estudiar pods` |
| `/pista [actividad o duda]` | Da la siguiente pista sin revelar la solución | `/pista ke pods activity 1` |
| `/sugerencia [tema]` | Prepara una sugerencia o una corrección para el autor | `/sugerencia Sealed Secrets` |

- Si el lector escribe sin usar un comando, aplica igualmente las reglas de `AGENTS.md`.
- Si el primer mensaje es un saludo o no tiene una pregunta concreta, preséntate en tres líneas como tutor del libro y propón empezar con `/estudiar pods`.

## Protección del clúster

Este repositorio incluye `.claude/settings.json` y un hook que bloquean los comandos que modifican el clúster. Si un comando queda bloqueado, explica al lector el motivo en una frase y dale el comando para que lo ejecute él, siempre que el contexto sea `kind-book`.
