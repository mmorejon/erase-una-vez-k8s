---
name: sugerencia
description: Prepara una sugerencia, una propuesta de cambio, una errata o un error de código para el autor del libro "Kubernetes: Érase Una Vez", y genera un enlace con el formulario de GitHub ya rellenado. Úsalo cuando el lector eche algo en falta en el libro, encuentre un error o quiera proponer un cambio.
argument-hint: "[tema]"
---

# /sugerencia

Tema que propone el lector: $ARGUMENTS

El objetivo es que escribir al autor le cueste un clic, sin saber usar GitHub. Tú preparas el texto; el lector lo revisa y lo envía.

## 1. Clasifica el caso

Si no está claro, pregúntale al lector qué quiere hacer:

| Caso | Formulario | Enlace base | Campos |
|------|------------|-------------|--------|
| Contenido que falta en el libro | Discussion «Ideas para futuras ediciones», tipo *Contenido nuevo* | `https://github.com/mmorejon/erase-una-vez-k8s/discussions/new?category=ideas-para-futuras-ediciones` | `tipo`, `capitulo`, `idea`, `propuesta` |
| Propuesta de cambio en el texto o el código | Discussion «Ideas para futuras ediciones», tipo *Cambio en el texto* o *Cambio en el código* | El mismo | El mismo |
| Errata en el texto | Issue «Errata o error en el código», tipo *Errata en el texto* | `https://github.com/mmorejon/erase-una-vez-k8s/issues/new?template=error.yml` | `tipo`, `capitulo`, `seccion`, `problem`, `logs`, `environment`, `correccion` |
| Código que falla o no coincide con el libro | Issue «Errata o error en el código», tipo *El código falla o no coincide con el libro* | El mismo | El mismo |
| Duda que no habéis podido resolver juntos | Discussion «Q&A (Preguntas y Ayuda)» | `https://github.com/mmorejon/erase-una-vez-k8s/discussions/new?category=q-a-preguntas-y-ayuda` | `capitulo`, `problem`, `logs`, `environment` |

Si es una duda, intenta resolverla primero con el lector. Usa Q&A solo si no lo conseguís.

## 2. Redacta un borrador breve

- Un título corto, que empiece por el prefijo del formulario: `[Idea] `, `[Error] ` o `[Duda] `.
- El contenido de cada campo, en pocas frases y en castellano.
- Usa la conversación: capítulo, sección, comando y salida mínima necesaria. No inventes datos que el lector no te ha dado.

## 3. Protege la privacidad

Antes de enseñar el borrador, elimina:

- Nombres, emails, IPs y nombres de equipos.
- Nombres de clústeres o contextos que no sean `kind-book`.
- Rutas personales (por ejemplo, `/Users/<nombre>/…` → `~/…`).
- Tokens, contraseñas y el contenido de cualquier Secret o kubeconfig.

## 4. Enseña el borrador

Muéstraselo al lector campo a campo y pregúntale si quiere cambiar algo. No sigas hasta que lo apruebe.

## 5. Genera el enlace

- Al enlace base, añade `&title=` y cada campo como `&<campo>=`, con los valores codificados para URL (espacios como `%20`, saltos de línea como `%0A`).
- Dile qué opción debe elegir en el desplegable `tipo`, por si no se selecciona sola.
- Muestra también el texto completo de cada campo para copiar y pegar, por si algún campo no se rellena solo o el enlace es demasiado largo.
- Recuérdale que necesita una cuenta de GitHub (es gratuita).

## 6. Nunca lo envíes tú

- No uses `gh`, la API de GitHub ni ninguna otra herramienta para publicarlo. El lector abre el enlace, revisa y pulsa «Enviar».
- Agradécele la aportación: así el libro mejora con las preguntas reales de sus lectores.
