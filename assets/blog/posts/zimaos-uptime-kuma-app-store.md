---
title: "Uptime Kuma en ZimaOS: instálalo desde la App Store y monitorea tus servicios"
excerpt: "Qué es Uptime Kuma, cómo instalarlo desde la App Store de ZimaOS y cómo recibir alertas (incluido un extra con bot de Telegram) sin vivir pegado al panel."
author: Alberto-Guaman
date: "2026-07-28"
categories: ["Linux", "Servidores", "Homelab", "Tutorial", "Monitoreo"]
tags: ["zimaos", "uptime-kuma", "monitoreo", "docker", "mini-pc", "app-store", "servidor-personal"]
image: /blog-images/zimaos-uptime-kuma-app-store.jpg
gradient: from-emerald-600 to-teal-700
readTime: 11 min
featured: true
---

Si ya tienes [ZimaOS como servidor en casa](/blog/zimaos-servidor-personal-nas) —en un **mini PC**, un equipo compatible o un NAS—, en poco tiempo acumulas cosas que “deberían estar siempre arriba”: archivos compartidos, Jellyfin, una web en Docker, el [Cloudflare Tunnel](/blog/zimaos-cloudflare-tunnels) o un sitio Astro que publicaste desde el mismo equipo.

El problema no es instalarlas. El problema es enterarte **cuando se caen**.

Ahí entra **Uptime Kuma**: un monitor de disponibilidad (uptime) con panel web, alertas y gráficos. En ZimaOS puedes instalarlo en minutos desde la **App Store**, sin armar a mano un `docker-compose` la primera vez.

ZimaOS no es “solo un NAS”: es el sistema del servidor doméstico. El almacenamiento en red es una de las piezas; Docker, multimedia, IA local y monitoreo viven en el mismo patio.

---

## ¿Qué es Uptime Kuma?

**Uptime Kuma** es una herramienta open source de monitoreo de uptime. La corres en tu servidor y desde el navegador configuras “monitores”: sitios web, APIs, ping a un host, puertos TCP, y más.

En la práctica responde preguntas simples:

- ¿Mi sitio responde HTTP 200?
- ¿El mini PC / servidor sigue vivo en la red?
- ¿El contenedor de Nginx/Astro contestó a tiempo?
- ¿Cuánto tiempo estuvo abajo este mes?

No reemplaza un APM empresarial ni un stack Prometheus completo. Es más cercano a “tengo un panel claro y me avisa por Telegram/Discord/email cuando algo falla”.

---

## ¿Para qué sirve?

En un **homelab** o **servidor personal** con ZimaOS (mini PC, equipo compatible o NAS), Uptime Kuma sirve sobre todo para tres cosas.

### 1. Vigilancia de servicios locales

Monitorea lo que corre en tu red: panel de ZimaOS, Jellyfin, Immich, n8n, Home Assistant, tu app en Docker, etc. Si un contenedor se detiene o el proceso se queda sin memoria, lo ves.

### 2. Vigilancia de sitios públicos

Si publicaste una web con [Astro/Vue + Docker + Tunnel](/blog/zimaos-astro-docker-hosting), conviene un monitor HTTP contra la URL pública (`https://tudominio.com`). Así detectas fallos de DNS, del tunnel o del contenedor.

### 3. Historial y alertas

No solo “está down ahora”. Guardas historial de uptime, latencia y ventanas de caída. Y puedes conectar notificaciones para que el aviso llegue al celular.

Si solo tienes un disco compartido y casi no corres servicios, puede sobrarte. Si ya tienes dos o tres cosas “siempre prendidas”, se vuelve útil muy rápido.

---

## Requisitos previos

Antes de instalar:

1. **ZimaOS** instalado y accesible desde el navegador en tu LAN.
2. Espacio en disco razonable (Uptime Kuma es liviano; el historial crece con el tiempo).
3. Decidir si lo usarás **solo en la red local** o también desde fuera (recomendado: detrás de tunnel / VPN, no exponer el panel a internet a lo bruto).

No necesitas saber Docker a fondo: la App Store de ZimaOS se encarga del contenedor.

---

## Instalar Uptime Kuma desde la App Store de ZimaOS

Este es el camino más corto.

### Paso 1: abre la App Store

1. Entra al panel web de ZimaOS (desde otro PC o tablet en la misma red).
2. Abre **App Store** (o el catálogo de aplicaciones / apps, según la versión de tu interfaz).

### Paso 2: busca Uptime Kuma

1. En el buscador escribe `Uptime Kuma` o `uptime-kuma`.
2. Abre la ficha de la app oficial del catálogo.

Revisa en la ficha:

- Puerto por defecto (suele ser **3001**).
- Si pide volumen/persistencia de datos (importante para no perder monitores al reiniciar).
- Requisitos de CPU/RAM (normalmente mínimos).

### Paso 3: instala y arranca

1. Pulsa **Install** / **Instalar**.
2. Espera a que ZimaOS descargue la imagen y cree el contenedor.
3. Cuando el estado pase a **Running** / **En ejecución**, abre la app desde el panel (botón Open / Abrir) o ve a:

```text
http://IP-DE-TU-ZIMAOS:3001
```

Si tu App Store permite elegir puerto, anótalo: ese número es el que usarás en la LAN.

### Paso 4: crea el usuario administrador

La primera vez Uptime Kuma te pide crear la cuenta admin (usuario y contraseña).

Usa una contraseña fuerte. Ese panel ve el estado de casi toda tu infraestructura: no lo dejes en `admin/admin`.

Con eso ya tienes el dashboard vacío listo para monitores.

---

## Primer uso: crea tu primer monitor

El flujo típico:

1. En el dashboard, **Add New Monitor**.
2. Elige el tipo. Para empezar, **HTTP(s)**.
3. Completa:
   - **Friendly Name**: por ejemplo `Web Tinguar` o `Jellyfin LAN`.
   - **URL**: `https://tudominio.com` o `http://192.168.x.x:8096`.
   - **Heartbeat Interval**: cada cuántos segundos revisa (60 s está bien para empezar).
   - **Retries**: reintentos antes de marcar “down” (evita falsas alarmas por un pico de red).
4. Guarda.

En unos segundos verás el estado en verde (Up) o rojo (Down), más el tiempo de respuesta.

Cuando entras a un monitor concreto ves el detalle: barras de heartbeat, latencia actual y promedio, uptime (24 h / 30 días / 1 año) y, si aplica, vencimiento de certificado SSL y del dominio.

![Detalle de un monitor HTTP en Uptime Kuma: minegociolisto.com en estado Up, latencia y gráfica de respuesta](/blog-images/uptime-kuma-monitor-detalle.jpg)

En el ejemplo de arriba el chequeo corre **cada 60 segundos**, el sitio responde `200 - OK` y el panel también te recuerda cuántos días faltan para renovar el certificado o el dominio. Eso es oro cuando hospedas varias webs y no quieres enterarte del SSL el día que Chrome pone el candado en rojo.

### Tipos de monitor útiles en un servidor ZimaOS

| Tipo | Cuándo usarlo |
|------|----------------|
| **HTTP(s)** | Sitios web, APIs, paneles con URL |
| **TCP Port** | Servicio que escucha un puerto (ej. 22 SSH, 3306 MySQL) |
| **Ping** | Host vivo en la red (router, otro PC, el propio servidor) |
| **Docker** | Contenedor concreto (si tu instalación lo soporta / tienes acceso al socket) |
| **Keyword** | La página debe contener (o no) un texto concreto |

Empieza con 3–5 monitores críticos. No hace falta monitorear “todo el universo” el día uno.

---

## Notificaciones: que te avise de verdad

Un panel bonito no sirve si solo lo miras cuando ya sabes que algo falló.

En Uptime Kuma ve a **Settings → Notifications** (o el flujo al crear/editar un monitor) y conecta un canal:

- Telegram (bot + chat ID)
- Discord / Slack
- Email
- Otros webhooks

Consejo práctico:

1. Crea la notificación.
2. Envíate un **test**.
3. Asígnasela a los monitores importantes (sitio público, tunnel, servidor).

Así, si cae tu web a las 2 a. m., lo sabes aunque no estés frente al dashboard.

---

## Extra: alertas con un bot de Telegram (sin abrir el panel)

Si quieres estar al pendiente **sin entrar al dashboard**, Telegram suele ser la opción más cómoda en un homelab: el aviso llega al celular como un chat normal.

La idea es simple:

1. Creas un **bot** con [@BotFather](https://t.me/BotFather) y copias el **token**.
2. Le escribes al bot (o lo agregas a un grupo) y obtienes el **Chat ID**.
3. En Uptime Kuma → **Settings → Notifications** eliges **Telegram**, pegas token + Chat ID y mandas un **Test**.
4. Asignas esa notificación a los monitores críticos.

Desde ahí, cuando un monitor pasa a Down (o vuelve a Up), el bot te escribe. No necesitas VPN ni abrir el panel solo para “ver si algo se cayó”.

> **Próximamente en el blog:** un post dedicado a montar el bot de Telegram con Uptime Kuma paso a paso (BotFather, Chat ID, pruebas y tips para no llenarte de ruido). Este apartado es solo el mapa rápido.

---

## Cómo usarlo en el día a día

### Vista rápida

El home de Uptime Kuma te muestra la lista de monitores a la izquierda (con % de uptime y sparkline) y, al centro, **Quick Stats**: cuántos están Up, Down, en mantenimiento, desconocidos o en pausa. Abajo va el **log de eventos**: cada cambio de estado con fecha, hora y mensaje.

![Dashboard de Uptime Kuma: lista de monitores, Quick Stats y log de eventos Up/Down](/blog-images/uptime-kuma-dashboard.jpg)

En una instalación real puedes tener juntos sitios públicos y servicios de LAN. En la captura, por ejemplo: `tinguar.com`, `minegociolisto.com` y dos monitores de Calculadora Feliz (local y público), todos en verde.

### Incidentes

Cuando algo cae, queda registrado el incidente: desde cuándo, hasta cuándo, y el mensaje de error. Eso ayuda a correlacionar con reinicios, actualizaciones de ZimaOS o cortes de red.

En el log de la captura se ve el patrón típico:

1. **Down** en Calculadora Feliz local: `connect ENETUNREACH 192.168.1.13:8080` (el host de la LAN no era alcanzable).  
2. **Down** en la URL pública: `getaddrinfo EAI_AGAIN …` (DNS / resolución falló en ese momento).  
3. Horas después, ambos vuelven a **Up** con `200 - OK`.

Sin ese historial, solo sabrías “hoy está bien”. Con el log, entiendes *qué* falló y *cuándo*.

### Status page (opcional)

Uptime Kuma permite una **status page** pública o semi-pública (“estado de nuestros servicios”). Útil si ofreces un servicio a clientes o a tu equipo. Si es solo para ti, puedes saltártela al inicio.

### Backups

Los monitores viven en el volumen del contenedor. Antes de borrar la app o mover de disco:

1. Haz backup desde la App Store / volúmenes de ZimaOS, **o**
2. Usa la exportación/backup que ofrezca Uptime Kuma en ajustes.

Perder monitores duele más de lo que parece: no es el software, es la configuración acumulada.

---

## Buenas prácticas con ZimaOS

- **No expongas el panel** en internet sin protección. Si necesitas verlo fuera de casa, usa [Cloudflare Tunnel](/blog/zimaos-cloudflare-tunnels) + acceso restringido, o VPN.
- **Monitorea la URL pública y la LAN** por separado cuando aplique: así sabes si falló el servicio local o solo el camino hacia Cloudflare.
- **Intervalos sensatos**: revisar cada 20 s un montón de hosts genera ruido y carga innecesaria. 60–120 s suele bastar en casa.
- **Actualiza** ZimaOS y la app: Uptime Kuma y el runtime Docker también reciben parches.
- **Alerta con criterio**: no todo merece ping al celular. Distingue “crítico” (web de producción, tunnel) de “nice to have” (lab de pruebas).

---

## Ejemplo mínimo de monitores en un homelab ZimaOS

Una configuración sensata para empezar:

1. `Ping` → IP del ZimaOS (¿el equipo está vivo?).
2. `HTTP` → panel local de ZimaOS (si aplica).
3. `HTTP(s)` → tu sitio público detrás del tunnel.
4. `HTTP` → Jellyfin / Immich / la app que más uses en LAN.
5. `TCP` o `HTTP` → el propio Uptime Kuma… mejor no; si el monitor se monitorea a sí mismo en el mismo host y el host muere, no te avisa igual. Prefiere un monitor externo o al menos un segundo punto de vista cuando crezcas.

Con esos cuatro ya cubres “máquina”, “panel”, “público” y “servicio estrella”.

---

## Conclusión

**Uptime Kuma** en **ZimaOS** es una de las primeras apps que valen la pena después de tener el servidor estable —da igual si es un mini PC, un board compatible o un NAS—: te dice si lo que instalaste sigue respondiendo, guarda historial y puede avisarte al instante.

Instalarlo desde la **App Store de ZimaOS** evita pelear con Docker al inicio. Luego el valor real está en:

1. Crear monitores HTTP/ping de lo crítico.  
2. Conectar notificaciones (Telegram es el atajo más práctico).  
3. Revisar incidentes cuando algo falle (y aprender de ellos).

Si todavía estás armando la base, el orden natural en este blog es:

1. [ZimaOS como servidor doméstico](/blog/zimaos-servidor-personal-nas)  
2. [Cloudflare Tunnels](/blog/zimaos-cloudflare-tunnels)  
3. [Hospedar Astro/Vue en Docker](/blog/zimaos-astro-docker-hosting)  
4. **Uptime Kuma** para vigilar que todo eso siga en pie  

Y **próximamente**: el tutorial completo del **bot de Telegram** con Uptime Kuma, para dejar el celular como “panel de guardia” sin entrar al dashboard cada rato.

Cuando lo tengas corriendo, el siguiente refinamiento suele ser el mismo: menos monitores “de adorno”, más alertas que sí miras.
