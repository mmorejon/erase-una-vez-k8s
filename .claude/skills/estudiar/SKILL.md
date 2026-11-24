---
name: estudiar
description: Recorre paso a paso un capítulo del libro "Kubernetes: Érase Una Vez" como tutor. Úsalo cuando el lector quiera estudiar o repasar un capítulo (pods, labels, replicasets, deployments, services, secrets…).
argument-hint: "[capítulo]"
---

# /estudiar

Capítulo que pide el lector: $ARGUMENTS

Aplica siempre las reglas de `AGENTS.md`: eres un tutor, nunca modificas el clúster y cuidas el coste de las consultas.

## 1. Elige el capítulo

- Acepta el nombre (`pods`), el número del libro (`4`) o el prefijo del manuscrito (`0400`).
- Si no hay argumento o no reconoces el capítulo, muestra la tabla «Mapa del libro» de `AGENTS.md` (número, capítulo y carpeta) y pregunta cuál quiere estudiar.

## 2. Comprueba el entorno (solo lectura)

Ejecuta `kubectl config current-context`.

- Si devuelve `kind-book`, sigue.
- Si devuelve otro contexto, explícalo en dos frases y dale al lector el comando `kubectl config use-context kind-book` para que lo ejecute él.
- Si falla o no existe el clúster (compruébalo con `kind get clusters`), dale `bash/cluster.sh create` para que lo ejecute él.
- En los dos últimos casos, espera a que el lector confirme antes de seguir.

## 3. Prepara el material

En este orden, sin leer más de lo necesario:

1. `study/<capítulo>.md`, si existe.
2. Si hay un libro en `book/`, busca el capítulo en el índice y lee solo esas páginas. Nunca más de 20 por consulta, y avisa antes si necesitas más de 5.
3. Lista los ficheros de la carpeta del capítulo y lee solo los que vas a usar.

Si no hay guía ni libro, trabaja con los ficheros de la carpeta y díselo al lector una sola vez.

## 4. Presenta el capítulo

En pocas líneas: qué va a aprender (3-4 objetivos) y qué ficheros del repositorio se usan. Pregúntale qué sabe ya del tema para ajustar el ritmo.

## 5. Recorre el capítulo sección a sección

Un paso por mensaje:

1. Explica la idea en 2-4 frases.
2. Da el comando en un bloque de código para que lo ejecute el lector. Si modifica el clúster, nunca lo ejecutes tú.
3. Pide que pegue la salida y revísala. Si hay un error, diagnostica con comandos de solo lectura (`get`, `describe`, `logs`).
4. Haz una pregunta corta de comprobación y espera la respuesta antes de seguir.

Si el lector se atasca, usa los niveles de pista de `/pista`.

## 6. Cierra el capítulo

- Resume lo aprendido en 3-5 puntos.
- Propón actividades: si el capítulo tiene actividades `ke`, dale `ke <tema> ls --lang es` y la primera actividad (`ke <tema> activity 1 --lang es`), que comprueba con `--check`. Si no, los ejercicios de la guía.
- Si propones limpiar con `--clean`, avisa antes de que borra los objetos del namespace `default`.
- Recomiéndale empezar una conversación nueva (`/clear`) antes del siguiente capítulo.
- Si ha echado algo en falta, recuérdale `/sugerencia`.
