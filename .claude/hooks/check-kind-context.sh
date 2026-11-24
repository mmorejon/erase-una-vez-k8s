#!/usr/bin/env bash
# Segunda barrera del tutor de IA: bloquea los comandos que modifican el clúster
# cuando el contexto actual de kubectl no es el clúster local del libro (kind-book).
# Claude Code lo ejecuta antes de cada comando Bash (PreToolUse) y le pasa un JSON
# por la entrada estándar. Sin dependencias: no necesita jq. Compatible con bash 3.2.

EXPECTED_CONTEXT="kind-book"

input="$(cat)"

matches() {
  printf '%s' "$input" | grep -Eq -- "$1"
}

modifies_cluster=0
if matches 'kubectl[^|;&]*[[:space:]](apply|create|delete|patch|edit|scale|exec|label|annotate|replace|drain|cordon|uncordon|run|expose|set|taint|autoscale)([[:space:]"]|$)'; then
  modifies_cluster=1
elif matches 'kubectl[^|;&]*[[:space:]]rollout[[:space:]]+(restart|undo|pause|resume)'; then
  modifies_cluster=1
elif matches '(^|[^[:alnum:]_-])ke[[:space:]][^|;&]*--(clean|raw-answer)'; then
  modifies_cluster=1
elif matches 'cluster\.sh|kind[[:space:]]+(create|delete)'; then
  modifies_cluster=1
fi

[ "$modifies_cluster" -eq 0 ] && exit 0

# Un clúster distinto indicado en el propio comando también cuenta.
if matches 'KUBECONFIG='; then
  echo "Bloqueado: el comando cambia KUBECONFIG. El tutor solo trabaja con el clúster local ${EXPECTED_CONTEXT}." >&2
  exit 2
fi
if matches '--context' && ! matches "--context[= ]${EXPECTED_CONTEXT}([[:space:]\"]|$)"; then
  echo "Bloqueado: el comando usa un contexto distinto de ${EXPECTED_CONTEXT}." >&2
  exit 2
fi

current="$(kubectl config current-context 2>/dev/null)"
if [ "$current" != "$EXPECTED_CONTEXT" ]; then
  echo "Bloqueado: este comando modifica el clúster y tu contexto actual es '${current:-ninguno}', no ${EXPECTED_CONTEXT}. Puede ser el clúster de tu empresa. Cambia de contexto tú mismo con: kubectl config use-context ${EXPECTED_CONTEXT}" >&2
  exit 2
fi

exit 0
