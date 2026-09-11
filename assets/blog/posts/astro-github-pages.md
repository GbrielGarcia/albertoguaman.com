---
title: "Guía para Crear y Desplegar una Página con Astro en GitHub Pages"
excerpt: "Aprende paso a paso cómo crear un sitio web con Astro y publicarlo gratis en GitHub Pages. Ideal para portafolios, blogs y proyectos personales."
author: Alberto-Guaman
date: "2024-12-21"
categories: ["Astro", "GitHub Pages", "Despliegue", "Web"]
tags: ["astro", "github-pages", "despliegue", "web", "tutorial", "gratis"]
image: /blog-images/guia-para-crear-y-desplegar-una-pagina-con-astro-en-github-pages.jpg
readTime: 10 min
---

> **¿Quieres publicar tu sitio Astro gratis y fácil?**  
> ¡GitHub Pages es la opción perfecta para proyectos estáticos y personales!

---

## ¿Por qué usar Astro + GitHub Pages?

- **Astro** genera sitios ultrarrápidos y modernos.
- **GitHub Pages** permite publicar gratis cualquier sitio estático.
- Ideal para portafolios, blogs, documentación y proyectos open source.

---

## Requisitos previos

- Tener Node.js y npm instalados ([descargar aquí](https://nodejs.org/)).
- Tener una cuenta en [GitHub](https://github.com/).
- Conocimientos básicos de terminal y git.

---

## Paso 1: Crear un nuevo proyecto Astro

```bash
npm create astro@latest
```

Sigue el asistente y elige la plantilla básica o la que prefieras.

---

## Paso 2: Inicializa un repositorio git y sube tu proyecto a GitHub

```bash
git init
git add .
git commit -m "Proyecto Astro inicial"
git branch -M main
git remote add origin https://github.com/tu-usuario/tu-repo.git
git push -u origin main
```

---

## Paso 3: Instala la integración de GitHub Pages para Astro

```bash
npm install @astrojs/github
```

Agrega la integración en tu `astro.config.mjs`:

```js
import { defineConfig } from 'astro/config';
import github from '@astrojs/github';

export default defineConfig({
  integrations: [github()],
  // ...otras opciones
});
```

---

## Paso 4: Configura el base path (si usas un subdirectorio)

Si tu sitio estará en `https://usuario.github.io/repositorio`, agrega en `astro.config.mjs`:

```js
export default defineConfig({
  base: '/repositorio/',
  // ...
});
```

---

## Paso 5: Genera el sitio estático

```bash
npm run build
```

Esto creará la carpeta `dist/` lista para publicar.

---

## Paso 6: Publica en GitHub Pages

Puedes usar la acción oficial de GitHub Actions para desplegar automáticamente:

1. Crea el archivo `.github/workflows/deploy.yml` en la raíz del proyecto:

```yaml
name: Deploy Astro site to GitHub Pages

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: withastro/action@v2
        with:
          path: .
```

2. Haz commit y push de este archivo:

```bash
git add .github/workflows/deploy.yml
git commit -m "Configura despliegue en GitHub Pages"
git push
```

3. Ve a la pestaña **Actions** en tu repositorio y verifica que el workflow se ejecute correctamente.

---

## Paso 7: Accede a tu sitio publicado

- Ve a la configuración de tu repositorio en GitHub.
- Busca la sección **Pages**.
- Verifica la URL de tu sitio (será algo como `https://usuario.github.io/repositorio/`).

¡Listo! Tu sitio Astro está en línea y gratis.

---

## Consejos y buenas prácticas

- Personaliza tu dominio con un archivo `CNAME` si tienes uno propio.
- Usa el comando `npm run preview` para revisar tu sitio antes de publicar.
- Mantén tu repositorio actualizado y documentado.

---

## Recursos útiles

- [Documentación oficial de Astro](https://docs.astro.build/es/)
- [Astro + GitHub Pages (docs)](https://docs.astro.build/en/guides/deploy/github/)
- [GitHub Actions para Astro](https://github.com/withastro/action)
- [GitHub Pages](https://pages.github.com/)

---

¿Listo para mostrar tu proyecto al mundo?  
¡Con Astro y GitHub Pages, publicar tu web nunca fue tan fácil! 