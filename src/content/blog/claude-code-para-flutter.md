---
title: "Cómo usar Claude Code para Flutter: guía práctica de principio a fin"
excerpt: "Instala Claude Code, conéctalo con el plugin oficial de Dart y Flutter, escribe un CLAUDE.md que entienda tu proyecto y automatiza analyze, format y tests. Con prompts reales, hooks, skills y subagentes."
author: Alberto-Guaman
date: "2026-10-23"
categories: ["Flutter", "IA", "Dart", "Herramientas", "Tutorial"]
tags: ["claude-code", "flutter", "dart", "ia", "agentes", "productividad", "mcp", "testing", "automatizacion"]
image: ./images/claude-code-para-flutter.jpg
readTime: "16 min"
featured: true
---

> **¿Quieres que la IA trabaje en tu app Flutter sin romperla?**
> Esta guía te lleva desde la instalación hasta un flujo en el que Claude Code escribe código, corre `flutter analyze` y `flutter test`, y te deja todo listo para revisar.

Usar un chat para programar en Flutter tiene un límite claro: copias código, lo pegas, falla, copias el error, lo pegas de vuelta… **Claude Code** rompe ese ciclo. Es un agente de programación de Anthropic que trabaja **dentro de tu proyecto**: lee los archivos, entiende la estructura, edita, ejecuta comandos como `flutter test` y corrige hasta que todo pasa.

Si todavía no tienes claro qué es un agente, empieza por [IA Agente: qué es y cómo funciona](/blog/ia-agente-agentic-ai). Aquí vamos directo a lo práctico con Flutter.

En esta guía vas a ver:

- Cómo instalar Claude Code y abrirlo en tu proyecto.
- El plugin oficial de Dart y Flutter, que le da acceso al analizador y a los tests.
- Cómo escribir un `CLAUDE.md` pensado para Flutter.
- El flujo de trabajo que mejor funciona: explorar, planificar, implementar y verificar.
- Prompts reales para tareas típicas de Flutter.
- Permisos, hooks, skills y subagentes para automatizar lo repetitivo.
- Errores comunes y cómo evitarlos.

---

## Qué necesitas antes de empezar

- **Flutter instalado** y funcionando (`flutter doctor` sin errores graves).
- **Un proyecto Flutter con Git.** No es obligatorio, pero es tu red de seguridad: si algo no te gusta, lo descartas con un `git checkout`.
- **Una cuenta de Claude con acceso a Claude Code:** plan Pro, Max, Team o Enterprise, o una cuenta de Console (API). El plan gratuito de claude.ai no lo incluye.
- macOS 13+, Windows 10 (1809+), Ubuntu 20.04+ o Debian 10+, y al menos 4 GB de RAM.

---

## 1. Instalar Claude Code

La forma recomendada es el instalador nativo, que además se actualiza solo.

En **macOS, Linux o WSL**:

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

En **Windows (PowerShell)**:

```powershell
irm https://claude.ai/install.ps1 | iex
```

Si prefieres un gestor de paquetes, también puedes usar `brew install --cask claude-code` en macOS o `winget install Anthropic.ClaudeCode` en Windows (estos no se actualizan solos).

Cierra y abre la terminal, y comprueba que quedó instalado:

```bash
claude --version
```

> ¿No te llevas bien con la terminal? Claude Code también tiene app de escritorio, extensión para **VS Code** y plugin para los IDE de JetBrains, incluido **Android Studio**. El flujo de esta guía es el mismo en todos.

---

## 2. Abrirlo en tu proyecto Flutter

Entra a la carpeta raíz de tu app (donde está `pubspec.yaml`) y ejecuta:

```bash
cd ~/proyectos/mi_app_flutter
claude
```

La primera vez te pide iniciar sesión en el navegador. Después verás un prompt donde escribes en lenguaje natural, en español sin problema.

Una buena primera pregunta para que Claude conozca el proyecto:

```text
Explícame la estructura de este proyecto: qué gestor de estado usa,
cómo está organizada la carpeta lib/ y qué paquetes son los más importantes.
```

Claude va a leer `pubspec.yaml`, recorrer `lib/` y responderte. **Todavía no cambia nada:** para leer no necesita permiso, para editar o ejecutar comandos sí te lo pide.

---

## 3. El plugin oficial de Dart y Flutter

El equipo de Flutter publica un plugin para Claude Code que incluye el **servidor MCP de Dart y Flutter**. Con él, Claude deja de "adivinar" y obtiene información real del SDK: diagnósticos del analizador, resolución de símbolos, ejecución de tests e inspección de la app en ejecución.

Instálalo con dos comandos (en tu terminal normal, no dentro de Claude):

```bash
claude plugin marketplace add flutter/agent-plugins
claude plugin install dart-flutter@dart-flutter
```

Para comprobar que quedó registrado:

```bash
claude plugin marketplace list
```

> Si usas otro cliente que solo acepta configuración MCP manual, el servidor se ejecuta con `dart mcp-server`. Con Claude Code, el plugin hace esa configuración por ti.

¿Por qué importa? Sin el plugin, Claude tiene que ejecutar `flutter analyze` y leer la salida como texto. Con él, consulta el analizador directamente, encuentra dónde está definido un widget o un provider, y corre solo los tests relevantes.

---

## 4. CLAUDE.md: las instrucciones de tu proyecto

Cada sesión de Claude Code empieza "en blanco". El archivo **`CLAUDE.md`** en la raíz del proyecto es lo primero que lee: ahí van los comandos, las convenciones y las decisiones de arquitectura que quieres que respete siempre.

La forma más rápida de crearlo es dentro de Claude:

```text
/init
```

Claude analiza el proyecto y genera un `CLAUDE.md` inicial con lo que descubre. Luego ajústalo con lo que **no** puede deducir solo. Este es un buen punto de partida para Flutter:

```markdown
# Mi App Flutter

App de ventas para tiendas: catálogo, carrito y pedidos. Android, iOS y web.

## Comandos
- Instalar dependencias: `flutter pub get`
- Analizar: `flutter analyze` (debe quedar sin issues antes de terminar una tarea)
- Formatear: `dart format lib test`
- Tests: `flutter test` (uno solo: `flutter test test/ruta/archivo_test.dart`)
- Generar código (freezed/json_serializable): `dart run build_runner build --delete-conflicting-outputs`
- Traducciones: `flutter gen-l10n`

## Arquitectura
- Por capas: `lib/data`, `lib/domain`, `lib/ui`, `lib/core`, `lib/routes`.
- Estado con Provider. No agregues Riverpod, Bloc ni GetX sin preguntar.
- Navegación con go_router; las rutas se registran en `lib/routes/app_router.dart`.

## Convenciones
- Widgets: un widget público por archivo, nombre del archivo en snake_case.
- Prefiere `const` en constructores y widgets siempre que se pueda.
- Textos visibles al usuario: siempre desde `AppLocalizations`, nunca hardcodeados.
- Colores y tipografía: desde `Theme.of(context)`, no valores sueltos.
- Cada pantalla nueva lleva al menos un widget test en `test/`.

## No tocar
- `lib/generated/` y archivos `*.g.dart` / `*.freezed.dart` (se generan).
- `android/app/google-services.json`, `ios/Runner/GoogleService-Info.plist` y keystores.
```

Algunos consejos:

- **Menos de 200 líneas.** Un `CLAUDE.md` largo consume contexto y se sigue peor.
- **Instrucciones concretas:** "corre `flutter analyze` antes de terminar" funciona mejor que "asegúrate de que el código sea bueno".
- **Súbelo a Git** para que todo el equipo comparta las mismas reglas. Lo personal va en `CLAUDE.local.md` (y ese al `.gitignore`).
- Puedes importar otros archivos con `@ruta`, por ejemplo `@docs/arquitectura.md`.

Si quieres profundizar en la estructura por capas que uso en el ejemplo, la explico en [Arquitectura Flutter por capas](/blog/flutter-arquitectura-por-capas).

### Reglas solo para ciertos archivos

Si tienes reglas que aplican solo a una parte del código, ponlas en `.claude/rules/` con un campo `paths`. Se cargan únicamente cuando Claude trabaja con esos archivos:

```markdown
---
paths:
  - "test/**/*_test.dart"
---

# Reglas para tests

- Usa `testWidgets` para widgets y `test` para lógica pura.
- Envuelve el widget en `MaterialApp` con los `localizationsDelegates` de la app.
- Nada de `Future.delayed` en tests: usa `tester.pump` / `pumpAndSettle`.
```

---

## 5. El flujo que mejor funciona: explorar, planificar, implementar, verificar

El error más común es pedir "haz la pantalla de pagos" y aceptar lo que salga. Funciona mucho mejor en cuatro pasos.

### Paso 1: explorar

Pídele que lea antes de escribir:

```text
Lee cómo está hecha la pantalla de catálogo (lib/ui/catalog/) y su provider.
Todavía no cambies nada.
```

### Paso 2: planificar con el modo plan

Pulsa **`Shift+Tab`** hasta ver el **modo plan** (o empieza el mensaje con `/plan`). En este modo Claude analiza y propone un plan, pero **no edita archivos**.

```text
Quiero una pantalla de detalle de producto con: imagen, nombre, precio,
selector de cantidad y botón "Agregar al carrito" que use el CartProvider
existente. Sigue el mismo patrón que la pantalla de catálogo.
Dame el plan de archivos a crear y modificar.
```

Lee el plan, corrígelo ("no uses un `StatefulWidget` para la cantidad, usa el provider") y aprueba cuando estés de acuerdo.

### Paso 3: implementar

Al aprobar, Claude crea y edita los archivos. Te pide permiso para cada edición, salvo que cambies al modo que acepta ediciones automáticamente (también con `Shift+Tab`).

### Paso 4: verificar

Este es el paso que marca la diferencia. Pídele que demuestre que funciona:

```text
Escribe widget tests para la pantalla de detalle (cantidad mínima 1,
el botón agrega al carrito), corre flutter analyze y flutter test,
y corrige lo que falle.
```

Claude ejecuta los comandos, lee los errores y repite hasta que todo pasa. Tú revisas el diff final con `git diff` y decides si se queda.

---

## 6. Prompts que funcionan para tareas típicas de Flutter

**Arreglar todos los warnings del analizador:**

```text
Corre flutter analyze y corrige todos los warnings e infos.
No cambies comportamiento; si alguno necesita una decisión mía, pregúntame.
```

**Corregir un overflow a partir de una captura:** puedes pegar una imagen en Claude Code (arrastrándola a la terminal o pegándola con `Ctrl+V`).

```text
[captura con la franja amarilla y negra]
Esta pantalla da RenderFlex overflow en celulares pequeños.
Es lib/ui/cart/cart_screen.dart. Corrígelo sin cambiar el diseño en pantallas grandes.
```

**Modo oscuro y diseño adaptable:**

```text
Agrega soporte de modo oscuro usando ThemeData y ColorScheme.fromSeed.
Revisa que ningún widget use colores fijos; reemplázalos por colores del tema.
```

Si quieres entender lo que va a hacer, tengo guías de [modo oscuro en Flutter](/blog/flutter-dark-mode) y de [texto responsivo](/blog/flutter-responsive).

**Actualizar dependencias sin romper nada:**

```text
Revisa flutter pub outdated. Propón qué actualizar y en qué orden,
explicando los breaking changes. Actualiza de a uno y corre los tests después de cada cambio.
```

**Migrar strings a internacionalización:**

```text
Busca textos hardcodeados en lib/ui/ y muévelos a lib/l10n/app_es.arb,
usando AppLocalizations. Corre flutter gen-l10n al final.
```

**Entender código ajeno:**

```text
¿Cómo llega un pedido desde que el usuario toca "Pagar" hasta que se guarda?
Muéstrame el recorrido por archivos y clases.
```

---

## 7. Permisos: menos interrupciones, sin perder el control

Por defecto Claude pregunta antes de ejecutar comandos. Para un proyecto Flutter conviene permitir los comandos seguros y bloquear el acceso a secretos. Crea `.claude/settings.json` en la raíz:

```json
{
  "permissions": {
    "allow": [
      "Bash(flutter analyze *)",
      "Bash(flutter test *)",
      "Bash(flutter pub get)",
      "Bash(dart format *)",
      "Bash(dart run build_runner *)",
      "Bash(flutter gen-l10n)"
    ],
    "deny": [
      "Read(./.env)",
      "Read(./android/key.properties)",
      "Read(./android/app/*.jks)",
      "Read(./android/app/google-services.json)",
      "Read(./ios/Runner/GoogleService-Info.plist)"
    ]
  }
}
```

- **`allow`:** Claude corre esos comandos sin preguntar. El `*` acepta cualquier argumento.
- **`deny`:** nunca podrá leer esos archivos, aunque se lo pidas.

No incluyas `flutter run` en `allow`: es un proceso que no termina y bloquea la sesión. Para probar la app en un emulador, córrela tú en otra terminal.

---

## 8. Hooks: que `dart format` se ejecute siempre

Las instrucciones de `CLAUDE.md` son sugerencias; Claude casi siempre las sigue, pero no hay garantía. Un **hook** sí es una garantía: es un comando que Claude Code ejecuta automáticamente en ciertos momentos.

Este hook formatea cada archivo `.dart` justo después de que Claude lo edita o lo crea. Agrégalo a `.claude/settings.json` junto a los permisos:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "f=$(jq -r '.tool_input.file_path'); case \"$f\" in *.dart) dart format \"$f\" ;; esac"
          }
        ]
      }
    ]
  }
}
```

Claude Code le pasa al hook un JSON con los datos de la edición; `jq` extrae la ruta del archivo y solo se formatea si termina en `.dart`. Necesitas tener `jq` instalado (`brew install jq` en macOS).

---

## 9. Skills: tus propios comandos

Una **skill** es un conjunto de instrucciones reutilizable que se convierte en un comando con `/`. Ideal para tareas que repites. Por ejemplo, crear una pantalla completa siguiendo tu arquitectura.

Crea `.claude/skills/nueva-pantalla/SKILL.md`:

```markdown
---
name: nueva-pantalla
description: Crea una pantalla Flutter nueva siguiendo la arquitectura del proyecto (ui + provider + ruta + test). Úsala cuando se pida una pantalla o feature nueva.
---

Crea la pantalla que se describe en los argumentos siguiendo estos pasos:

1. Lee una pantalla existente en `lib/ui/` como referencia de estilo.
2. Crea `lib/ui/<feature>/<feature>_screen.dart` con widgets `const` cuando se pueda.
3. Si necesita estado, crea `lib/ui/<feature>/<feature>_provider.dart` con ChangeNotifier
   y regístralo donde se registran los demás providers.
4. Registra la ruta en `lib/routes/app_router.dart`.
5. Textos en `lib/l10n/app_es.arb` y corre `flutter gen-l10n`.
6. Crea `test/ui/<feature>/<feature>_screen_test.dart` con al menos un widget test.
7. Corre `flutter analyze` y `flutter test`; corrige hasta que pasen.
8. Resume qué archivos creaste y cuáles modificaste.
```

Desde ese momento puedes escribir:

```text
/nueva-pantalla historial de pedidos con filtro por fecha
```

Si la subes a Git, todo tu equipo tiene el mismo comando.

---

## 10. Subagentes: un especialista en tests

Un **subagente** es otra instancia de Claude con su propio contexto, instrucciones y herramientas. Sirve para tareas que generan mucho "ruido" (leer muchos archivos, correr tests una y otra vez) sin llenar tu conversación principal.

Crea `.claude/agents/flutter-tester.md`:

```markdown
---
name: flutter-tester
description: Escribe y repara widget tests y unit tests de Flutter. Úsalo después de crear o modificar pantallas, o cuando fallen tests.
tools: Read, Edit, Write, Glob, Grep, Bash
---

Eres especialista en testing de Flutter.

- Usa testWidgets para widgets y test para lógica pura.
- Prueba comportamiento visible (textos, taps, navegación), no detalles internos.
- Usa mocks simples hechos a mano antes que agregar paquetes nuevos.
- Corre `flutter test` después de cada cambio y no termines con tests en rojo.
- Al final, devuelve un resumen corto: tests creados, tests corregidos y cualquier bug real que encontraste.
```

Lo puedes llamar de forma explícita:

```text
Usa el subagente flutter-tester para cubrir con tests lib/ui/cart/
```

O con `@` y eligiéndolo de la lista. Claude también lo usará por su cuenta cuando la tarea coincida con la descripción.

---

## 11. Comandos de Claude Code que más vas a usar

| Comando o atajo | Para qué sirve |
|---|---|
| `/init` | Genera o mejora el `CLAUDE.md` del proyecto |
| `Shift+Tab` | Cambia de modo: normal → aceptar ediciones → plan |
| `/plan` | Envía un solo mensaje en modo plan |
| `/clear` | Empieza una conversación nueva (úsalo al cambiar de tarea) |
| `/compact` | Resume la conversación para liberar contexto |
| `/context` | Muestra qué está ocupando el contexto |
| `/permissions` | Revisa y edita los permisos |
| `/mcp` | Estado de los servidores MCP (como el de Dart y Flutter) |
| `/agents` | Gestiona subagentes |
| `@archivo` | Menciona un archivo para que lo lea, por ejemplo `@lib/main.dart` |
| `Esc` | Detiene a Claude en lo que esté haciendo |

### Modo no interactivo

Con `-p`, Claude Code responde y termina, útil para scripts o integración continua:

```bash
claude -p "Corre flutter analyze y resume los problemas por archivo, sin corregir nada"
```

---

## Errores comunes (y cómo evitarlos)

**Pedir demasiado de una vez.** "Haz el módulo de pagos completo" termina en cientos de líneas difíciles de revisar. Divide: modelo, provider, pantalla, tests.

**No darle una forma de verificar.** Sin tests ni `flutter analyze`, Claude no sabe si su código funciona, y tú tampoco. Pide siempre que verifique.

**Conversaciones eternas.** Mezclar cinco tareas en la misma sesión llena el contexto y empeora las respuestas. Usa `/clear` al cambiar de tarea.

**Aceptar sin leer.** Revisa el diff antes de hacer commit. Claude es muy bueno, pero el responsable del código sigues siendo tú.

**Dejar que toque archivos generados.** Si edita un `*.g.dart`, el próximo `build_runner` lo pisa. Indícalo en `CLAUDE.md` y pídele que regenere en lugar de editar.

**Exponer secretos.** Bloquea con `deny` keystores, `google-services.json` y `.env`. Nunca pegues claves de API en la conversación.

---

## ¿Cuánto cuesta?

Claude Code se incluye en los planes de pago de Claude (Pro, Max, Team y Enterprise), con límites de uso según el plan. Con una cuenta de Console pagas por uso de la API. Para trabajo diario en una app Flutter, el plan Pro suele alcanzar para empezar; si trabajas muchas horas al día con el agente, Max da bastante más margen.

---

## Preguntas frecuentes

**¿Funciona en Windows?**
Sí. Se instala desde PowerShell o CMD, o dentro de WSL. En Windows nativo conviene instalar Git for Windows para que Claude pueda usar Bash.

**¿Puede correr mi app en el emulador?**
Puede ejecutar comandos, pero `flutter run` no termina nunca y bloquea la sesión. Lo práctico es que tú tengas la app corriendo con hot reload en otra terminal mientras Claude edita el código.

**¿Sirve para proyectos grandes o heredados?**
Sí, y ahí es donde más ayuda: explicar código que no escribiste, encontrar dónde se usa algo y hacer refactors con tests de respaldo. Empieza siempre con preguntas de exploración antes de pedir cambios.

**¿Reemplaza a GitHub Copilot o al autocompletado del IDE?**
Son complementarios. El autocompletado te ayuda línea a línea mientras escribes; Claude Code se encarga de tareas completas de varios archivos y las verifica.

**¿Mi código se usa para entrenar modelos?**
Depende del tipo de cuenta y de tu configuración de privacidad. Revísala en la configuración de tu cuenta de Claude antes de trabajar con código de clientes.

---

## Conclusión

Claude Code no es "autocompletado con esteroides": es un compañero que lee tu proyecto, propone un plan, escribe el código y **comprueba que funciona** con las mismas herramientas que usas tú. Con un buen `CLAUDE.md`, el plugin de Dart y Flutter, permisos claros y un par de hooks, pasa de ser un experimento a ser parte de tu flujo diario.

Mi recomendación para empezar hoy:

1. Instálalo y corre `/init` en tu app.
2. Agrega el plugin oficial de Dart y Flutter.
3. Pídele que arregle los warnings de `flutter analyze`.
4. Luego, una pantalla pequeña con su widget test, usando el modo plan.

¿Lo estás usando en tu proyecto Flutter o quieres implementarlo en tu equipo? [Escríbeme](/contacto) y lo conversamos.
