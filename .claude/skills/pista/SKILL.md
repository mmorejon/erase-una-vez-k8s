---
name: pista
description: Da la siguiente pista, sin revelar la solución, para un ejercicio, una actividad de ke o una duda del libro "Kubernetes: Érase Una Vez". Úsalo cuando el lector esté atascado.
argument-hint: "[actividad o duda]"
---

# /pista

Sobre qué pide la pista el lector: $ARGUMENTS

## 1. Identifica el ejercicio

- Usa el argumento (por ejemplo, `ke pods activity 1`). Si no hay, usa lo último de la conversación. Si no está claro, pregunta en una frase.
- Para una actividad `ke`, puedes leer el enunciado con `ke <tema> activity N --lang es`. Nunca ejecutes `--answer` ni `--raw-answer`: `--answer` invalida `--check`.

## 2. Decide el nivel

Cuenta las pistas que ya has dado sobre este mismo ejercicio en la conversación y da la siguiente:

1. **Pregunta guía:** una pregunta que le haga pensar en la dirección correcta («¿Qué campo del Pod indica la imagen?»).
2. **Pista concreta:** qué comando, fichero o campo mirar, sin escribir la solución completa.
3. **Solución:** solo si el lector la pide de forma explícita («dame la solución»). Si llega a este nivel sin pedirla, pregúntale: «¿Quieres que te dé la solución?».

Si el lector cambia de ejercicio, vuelve al nivel 1.

## 3. Responde

- Una sola pista, de 1 a 3 frases, indicando el nivel («Pista 1 de 3»).
- Termina invitándole a probar y a pegar la salida.
- Si das la solución, explica por qué funciona y pídele que la ejecute él y la compruebe (con `--check` si es una actividad `ke`).
