---
title: "Cómo Iniciar un Repositorio en Git: Una Guía Paso a Paso"
excerpt: "Aprende a crear y configurar tu primer repositorio Git desde cero. Desde la inicialización hasta el primer commit, te guiamos en todo el proceso."
author: Alberto-Guaman
date: "2025-01-03"
categories: ["Git", "Control de Versiones", "Desarrollo", "Tutorial"]
tags: ["git", "control-versiones", "desarrollo", "tutorial", "repositorio", "commit", "github", "principiante"]
image: /blog-images/como-iniciar-un-repositorio-en-git-una-guia-paso-a-paso.jpg
readTime: 6 min
---

> **¿Quieres llevar el control de tus proyectos y colaborar fácilmente?**  
> ¡Aprende a usar Git y crea tu primer repositorio en minutos!

---

## ¿Qué es Git y por qué usarlo?

Git es un sistema de control de versiones distribuido. Permite guardar el historial de cambios de tus archivos, colaborar con otros y revertir errores fácilmente.

- **Historial seguro:** Nunca pierdes tu trabajo.
- **Colaboración:** Trabaja en equipo sin sobrescribir cambios.
- **Popularidad:** Es el estándar en la industria del software.

---

## Paso 1: Instala Git

Descarga e instala Git desde [git-scm.com](https://git-scm.com/).

Verifica la instalación en la terminal:

```bash
git --version
```

---

## Paso 2: Configura tu usuario

Antes de crear tu primer repositorio, configura tu nombre y correo:

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

---

## Paso 3: Crea una carpeta para tu proyecto

```bash
mkdir mi-proyecto
tcd mi-proyecto
```

---

## Paso 4: Inicializa el repositorio

```bash
git init
```

Esto crea una carpeta oculta `.git` donde Git guarda el historial.

---

## Paso 5: Agrega archivos y haz tu primer commit

1. Crea un archivo, por ejemplo `README.md`:

```bash
echo "# Mi Proyecto" > README.md
```

2. Agrega los archivos al área de preparación (staging):

```bash
git add .
```

3. Haz tu primer commit:

```bash
git commit -m "Primer commit: agrega README"
```

---

## Paso 6: Conecta tu repositorio local con GitHub (opcional)

1. Crea un repositorio vacío en [GitHub](https://github.com/new).
2. Conéctalo con tu repositorio local:

```bash
git remote add origin https://github.com/tu-usuario/mi-proyecto.git
git branch -M main
git push -u origin main
```

---

## Comandos útiles de Git

- `git status`: Ver el estado de los archivos.
- `git log`: Ver el historial de commits.
- `git diff`: Ver diferencias entre archivos.
- `git add archivo.txt`: Agregar un archivo específico.
- `git commit -m "mensaje"`: Guardar cambios con mensaje.
- `git push`: Subir cambios a un repositorio remoto.
- `git pull`: Traer cambios del repositorio remoto.

---

## Buenas prácticas

- Escribe mensajes de commit claros y descriptivos.
- Haz commits frecuentes y pequeños.
- Usa `.gitignore` para excluir archivos que no quieres versionar.
- Sincroniza regularmente con el repositorio remoto.

---

## Recursos útiles

- [Pro Git Book (español)](https://git-scm.com/book/es/v2)
- [GitHub Docs](https://docs.github.com/es)
- [Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)

---

¿Listo para versionar tus proyectos como un profesional?  
¡Con Git, tu código siempre estará seguro y bajo control! 