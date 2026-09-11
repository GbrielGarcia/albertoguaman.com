---
title: "Arquitectura Flutter por capas: ordena tu proyecto sin pelearte con el caos"
excerpt: "Cómo organizar un proyecto Flutter en capas (Data, Domain, UI, Core y Routes): carpetas, responsabilidades y un flujo claro de punta a punta."
author: Alberto-Guaman
date: "2026-07-29"
categories: ["Flutter", "Arquitectura", "Dart", "Tutorial"]
tags: ["flutter", "arquitectura", "capas", "clean-architecture", "getx", "dart", "estructura", "escalabilidad"]
image: /blog-images/flutter-arquitectura-por-capas.jpg
gradient: from-sky-600 to-blue-700
readTime: 10 min
featured: true
---

Cuando una app Flutter crece, el problema casi nunca es “falta un widget”. El problema es que todo termina mezclado: pantallas que llaman APIs, modelos sueltos, estado en cualquier lado y carpetas que solo el autor entiende.

Una **arquitectura por capas** no te hace magia. Te da un mapa: dónde vive cada cosa y cómo viaja una acción del usuario hasta el servidor (y de vuelta).

En este post usamos como base un esquema tipo **arquitectura por capas** (Data, Domain, UI, Routes y Core), con features por módulo. El objetivo es que puedas copiar la estructura y, sobre todo, entender el **flujo**.

---

## El mapa visual

![Diagrama de arquitectura Flutter por capas: carpetas, capas y flujo de la aplicación](/blog-images/flutter-arquitectura-por-capas-diagrama.png)

A la izquierda: carpetas. A la derecha: responsabilidades. Abajo: el camino de una acción. Si algo no encaja en una caja, normalmente estás mezclando capas.

---

## ¿Para qué sirve esto?

Sirve cuando:

- La app ya no es un CRUD de una pantalla.
- Varias personas tocan el mismo repo.
- Quieres probar lógica sin montar toda la UI.
- Vas a sumar módulos (`auth`, `home`, `profile`) sin romper lo anterior.

Si es un prototipo de un fin de semana, puedes vivir con menos formalidad. Cuando el proyecto “se queda”, la estructura se paga sola.

---

## Estructura de carpetas (versión práctica)

Idea base bajo `lib/`:

```text
lib/
├── app/
│   ├── data/
│   │   └── models/
│   │       ├── request/
│   │       └── response/
│   ├── domains/
│   │   ├── auth/
│   │   ├── home/
│   │   └── profile/
│   │       ├── bindings/      # opcional (GetX)
│   │       ├── providers/     # o solo controllers, ver más abajo
│   │       ├── repositories/
│   │       └── services/
│   ├── ui/
│   │   ├── auth/
│   │   ├── home/
│   │   └── splash/
│   │       ├── controllers/
│   │       ├── views/
│   │       └── widgets/
│   └── routes/
│       ├── app_routes.dart
│       └── app_pages.dart
└── core/
    ├── network/
    └── storage/
```

Regla corta:

| Carpeta | Pregunta que responde |
|---------|------------------------|
| `data/models` | ¿Cómo viajan los datos hacia/desde la API? |
| `domains/...` | ¿Cuál es la lógica y el acceso a datos de este feature? |
| `ui/...` | ¿Qué ve y toca el usuario? |
| `routes/` | ¿Cómo navego entre pantallas? |
| `core/` | ¿Qué es compartido (HTTP, tokens, preferencias)? |

---

## Capas y responsabilidades

### Data

Aquí viven los **modelos de transporte**: request y response. Serializan JSON, tipan el contrato con el backend.

No metes reglas de negocio (“si el usuario es premium, desbloquea X”) en un `response`. Eso es Domain/Services.

### Domain (por feature)

Organizado por funcionalidad (`auth`, `home`, `profile`). Suele incluir:

- **Repository:** habla con la fuente de datos (API vía `core/network`, a veces cache en `core/storage`).
- **Services:** orquestan casos de uso (login, cargar perfil, refrescar lista).
- **Provider / estado de dominio** (si lo usas): expone datos listos para la UI.

### UI

Solo presentación:

- **Views:** pantallas.
- **Widgets:** piezas reutilizables del módulo.
- **Controllers** (p. ej. GetX): reaccionan al gesto del usuario, llaman a Domain y actualizan lo que se pinta.

La UI no debería conocer URLs, headers ni el detalle del JSON crudo.

### Routes

Navegación centralizada (`app_routes`, `app_pages`). No es una “capa de negocio”; es configuración. Tenerla junta evita `Navigator.push` desperdigados sin criterio.

### Core

Transversal: cliente HTTP, interceptores, tokens, preferencias. Domains y UI consumen Core; Core no debería depender de un feature concreto.

---

## El flujo que sí conviene memorizar

En muchos diagramas se mezclan dos secuencias. Para el día a día, deja **una** sola:

```text
Usuario toca la UI (View)
        ↓
   Controller
        ↓
    Service          ← orquesta el caso de uso
        ↓
  Repository         ← pide/guarda datos
        ↓
 core/network|storage
        ↓
  models request/response (Data)
```

Y de vuelta: el Repository/Service devuelve algo usable → el Controller actualiza estado → la View se redibuja.

### ¿Y el Provider?

Si usas **GetX**, el `Controller` suele ser suficiente como dueño del estado de la pantalla. Meter **Controller + Provider** en el mismo feature sin regla clara termina en “¿quién manda?”.

Opciones sanas:

1. **GetX:** View → Controller → Service → Repository.  
2. **Provider / Riverpod:** View → (Notifier/Provider) → Service → Repository.

Elige una línea y documéntala en el README del repo. La arquitectura aguanta ambas; lo que no aguanta es las dos a la vez sin criterio.

---

## Ejemplo mental: login

1. La vista `LoginView` captura email y password.  
2. `LoginController` valida campos básicos y llama `AuthService.login(...)`.  
3. `AuthService` arma el caso de uso (¿hay sesión previa? ¿hay que guardar token?).  
4. `AuthRepository` usa `core/network` con un `LoginRequest`.  
5. La API responde → `LoginResponse` en `data/models/response`.  
6. El service guarda el token en `core/storage`.  
7. El controller navega a Home vía Routes.

Si el widget de login hiciera el `http.post` directo, el día que cambie el endpoint o el auth, tocas UI. Con capas, tocas Repository/Network.

---

## Errores típicos (y cómo evitarlos)

- **UI que importa `core/network`:** salta Domain. Peor mantenimiento.  
- **Models de API usados como modelo de negocio en toda la app:** acoplas pantallas al JSON del backend.  
- **God Service / God Controller:** un archivo que hace de todo. Parte por feature.  
- **Core que importa `domains/home`:** dependencia al revés. Core debe ser “abajo”.  
- **Copiar carpetas vacías “porque el diagrama las tiene”:** empieza por un feature real (`auth`) y completa el resto cuando duela.

---

## Relación con otros temas del blog

Si todavía estás en estado y widgets, te conviene leer antes:

- [Manejando estados con Flutter y Provider](/blog/flutter-provider)  
- [Guía de Dart: fundamentos](/blog/dart-fundamentos)

La arquitectura por capas no reemplaza saber Dart/Flutter: les pone **sitio** a lo que ya haces.

---

## Conclusión

Una arquitectura Flutter por capas te da tres cosas: **dónde poner código nuevo**, **quién puede llamar a quién** y **cómo explicar el proyecto** a otra persona.

Quédate con este checklist:

1. Models de API en `data`.  
2. Lógica y acceso a datos por feature en `domains`.  
3. Pantallas y controllers en `ui`.  
4. HTTP/storage en `core`.  
5. Un solo flujo: **UI → Controller → Service → Repository → Data/Core**.

No hace falta que el día uno esté “perfecto”. Hace falta que cada PR sepa en qué carpeta cae. Cuando eso pasa, el proyecto deja de pelearte… y empieza a crecer con menos drama.
