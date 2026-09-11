---
title: "ZimaOS y Cloudflare Tunnels: expón tu NAS sin abrir puertos"
excerpt: "Cómo usar Cloudflare Tunnels con ZimaOS para acceder a tu servidor desde fuera sin reenvío de puertos ni exponer la red de casa."
author: Alberto-Guaman
date: "2026-07-14"
categories: ["Linux", "Servidores", "NAS", "Seguridad", "Tutorial"]
tags: ["zimaos", "cloudflare", "tunnels", "nas", "seguridad"]
image: /blog-images/zimaos-cloudflare-tunnels.jpg
gradient: from-sky-600 to-indigo-700
readTime: 8 min
featured: true
---

Montar un **NAS** o un **servidor personal** con **ZimaOS** resuelve la mitad del problema: tus archivos y servicios viven en casa. La otra mitad aparece cuando quieres abrir Jellyfin, el panel o una web desde el celular… y el router, el ISP o el CGNAT te frenan.

La solución típica es reenviar puertos 80/443. Funciona, pero deja la casa “escuchando” internet. **Cloudflare Tunnels** da la vuelta: tu infraestructura solo crea conexiones **de salida** hacia Cloudflare. No abres puertos de entrada.

---

## El problema de abrir el NAS a internet

Con ZimaOS puedes tener nube privada, multimedia, Docker, APIs o incluso IA local. Eso está bien dentro de la LAN. Fuera de casa pasan tres cosas:

1. No todos tienen IP pública estable.  
2. Muchos routers/ISP no dejan (o no conviene) hacer port forwarding.  
3. Cada puerto abierto es superficie de ataque.

Si tu idea era “solo abro el 443 un rato”, ya viste cómo ese rato se vuelve permanente.

---

## Qué es un Cloudflare Tunnel (en corto)

Un **Tunnel** es un conector (el proceso `cloudflared`) que corre cerca de tus servicios. Ese conector **sale** solo hacia la red de Cloudflare y mantiene el túnel abierto.

Tráfico típico:

`usuario → Cloudflare → túnel → tu servicio en ZimaOS`

Importante:

- No necesitas puertos de entrada en el router.  
- El origen (tu mini PC / NAS) no queda como IP pública abierta.  
- Sirve aunque estés detrás de CGNAT.  
- Solo decides qué hostname apunta a qué servicio interno (por ejemplo `media.tudominio.com` → Jellyfin en Docker).

Eso encaja muy bien con un **servidor doméstico**: privatizas el perímetro y dejas que Cloudflare sea la puerta visible.

---

## Por qué pega tan bien con ZimaOS

ZimaOS ya te da la base Linux/NAS y, en la práctica, un patio de Docker. Ahí puedes correr:

- el panel o apps del sistema  
- un reverse proxy (si quieres ordenar rutas)  
- `cloudflared` como contenedor o servicio  

La combinación razonable es:

1. Servicios en Docker dentro de ZimaOS.  
2. Tunnel hacia Cloudflare (solo salida).  
3. DNS del dominio en Cloudflare apuntando al tunnel.  
4. Opcional: Cloudflare Access / reglas para no dejar el panel abierto al mundo.

No es “magia Zero Trust”. Es una arquitectura más limpia que abrir el puerto 443 a tu casa.

---

## Qué conviene publicar (y qué no)

Tiene sentido meter por el tunnel:

- media (Jellyfin/Plex)  
- un dashboard de uptime  
- una web o API de prueba  
- Open WebUI / herramientas internas con autenticación  

Piénsalo dos veces antes de exponer:

- paneles de admin sin login fuerte  
- bases de datos  
- Home Assistant o n8n sin capas extra  

El tunnel reduce el riesgo de escanear tu IP de casa. No elimina la necesidad de autenticación, actualizaciones y backups.

---

## Cómo se ve el flujo diario

Sin tonterías de checklist infinito:

1. Tienes ZimaOS arriba y un servicio escuchando en la red interna (por ejemplo `localhost:8096`).  
2. Creas un tunnel en Cloudflare Zero Trust / dashboard.  
3. Corres `cloudflared` en el mismo equipo (o en Docker en ZimaOS) con el token del tunnel.  
4. Mapeas `app.tudominio.com` → `http://servicio:puerto`.  
5. Pruebas desde datos móviles (fuera del Wi‑Fi de casa).

Si entra, felicitaciones: entraste sin abrir un solo puerto de entrada.

---

## Comparación rápida

| Enfoque | Qué implica |
|--------|-------------|
| Port forwarding | Abres 80/443 hacia el NAS. Simple, más expuesto. |
| VPN a casa | Seguro, pero todos “entran” a la LAN. |
| Cloudflare Tunnel | Solo salida. Hostname limpio. Origen oculto detrás de Cloudflare. |

Para muchos homelabs con ZimaOS, el tunnel gana cuando quieres HTTPS decente y cero pelea con el router.

---

## Detalles prácticos que sí importan

- **Firewall:** solo output; `cloudflared` habla principalmente por el puerto **7844** (UDP/TCP) hacia Cloudflare.  
- **Docker:** puedes aislar el connector en su red y apuntar a contenedores por nombre.  
- **Dominio:** conviene que el DNS esté en Cloudflare; el tunnel usa hostnames limpios.  
- **Actualiza:** mantén ZimaOS, apps y `cloudflared` al día. Un tunnel no perdona software viejo con bugs.  
- **No publiques de más:** empieza con un servicio. Luego otro. Evita “abro todo el stack”.

Si ya leíste el post anterior sobre ZimaOS, esto es el siguiente capítulo natural: de “tengo servidor en casa” a “lo uso fuera sin dejar la casa a la intemperie”.

---

## Conclusión

**ZimaOS** te da el NAS/servidor. **Cloudflare Tunnels** te da el acceso remoto sin abrir puertos de entrada: conexiones seguras de salida desde tu infraestructura hacia Cloudflare.

Si estás armando nube privada, multimedia o apps en Docker, prueba primero un solo hostname (por ejemplo media o status). Cuando eso sea estable, recién ahí suma el resto.

Y si todavía no tienes el NAS listo, empieza por [entender ZimaOS](/blog/zimaos-servidor-personal-nas) y después conecta el tunnel. Ese orden evita confusiones.

Cuando el tunnel ya esté estable, el siguiente capítulo es [hospedar Astro o Vue en ZimaOS con Docker](/blog/zimaos-astro-docker-hosting): build estático, Nginx y tu dominio público sin abrir puertos.
