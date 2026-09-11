---
title: "Cómo Desplegar tu Sitio Flutter Web en Firebase Hosting"
excerpt: "Guía completa para desplegar tu aplicación Flutter Web en Firebase Hosting. Desde la configuración hasta el despliegue, aprende a publicar tu app en la nube de Google."
author: Alberto-Guaman
date: "2024-12-19"
categories: ["Flutter", "Firebase", "Hosting", "Despliegue"]
tags: ["flutter", "firebase", "hosting", "despliegue", "web", "google", "tutorial", "cloud"]
image: /blog-images/como-desplegar-tu-sitio-flutter-web-en-firebase-hosting.jpg
readTime: 8 min
---

> **¿Quieres que tu app Flutter Web esté disponible para todo el mundo?**  
> ¡Firebase Hosting es una de las formas más rápidas y sencillas de lograrlo!

---

## ¿Por qué usar Firebase Hosting para Flutter Web?

- **Gratis para proyectos pequeños y personales**
- **SSL automático** (https)
- **Despliegue rápido y sencillo**
- **Integración con otros servicios de Firebase**

---

## Requisitos previos

- Tener Flutter instalado ([guía oficial](https://docs.flutter.dev/get-started/install))
- Tener una cuenta de Google
- Tener Node.js y npm instalados ([descargar aquí](https://nodejs.org/))

---

## Paso 1: Crea y construye tu proyecto Flutter Web

1. Si aún no tienes un proyecto:

```bash
flutter create mi_flutter_web
cd mi_flutter_web
```

2. Construye la versión web:

```bash
flutter build web
```

Esto generará la carpeta `build/web` con los archivos listos para desplegar.

---

## Paso 2: Instala las herramientas de Firebase

```bash
npm install -g firebase-tools
```

Inicia sesión en Firebase:

```bash
firebase login
```

---

## Paso 3: Inicializa Firebase Hosting en tu proyecto

```bash
firebase init
```

- Selecciona **Hosting** (puedes usar barra espaciadora para marcar)
- Elige el proyecto de Firebase que usarás (o crea uno nuevo en la consola de Firebase)
- Define la carpeta pública como `build/web`
- Elige **No** para configurar como SPA (a menos que uses rutas internas)
- Elige **No** para sobrescribir `index.html` si te lo pregunta

---

## Paso 4: Despliega tu sitio

```bash
firebase deploy
```

¡Listo! Firebase te dará una URL pública como:

```
https://tu-proyecto.web.app
```

---

## Buenas prácticas y consejos

- Usa `flutter build web --release` para producción
- Personaliza tu dominio desde la consola de Firebase si lo deseas
- Usa HTTPS siempre (Firebase lo activa por defecto)
- Si usas rutas internas, configura `rewrites` en `firebase.json`

---

## Ejemplo de archivo `firebase.json` para SPA

```json
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      { "source": "**", "destination": "/index.html" }
    ]
  }
}
```

---

## Recursos útiles

- [Flutter Web: Documentación oficial](https://docs.flutter.dev/platform-integration/web)
- [Firebase Hosting: Documentación oficial](https://firebase.google.com/docs/hosting)
- [Guía de despliegue Flutter Web + Firebase (YouTube)](https://www.youtube.com/results?search_query=flutter+web+firebase+hosting)

---

¿Listo para mostrar tu app Flutter Web al mundo?  
¡Con Firebase Hosting, el despliegue es rápido, seguro y gratuito! 