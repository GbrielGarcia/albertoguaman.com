---
title: "Hospedar Astro o Vue en ZimaOS con Docker y Cloudflare Tunnel"
excerpt: "Proceso real: build estático, Nginx en Docker, docker-compose en ZimaOS y dominio público con Cloudflare Tunnel sin abrir puertos."
author: Alberto-Guaman
date: "2026-07-21"
categories: ["Linux", "Servidores", "NAS", "Astro", "Tutorial"]
tags: ["zimaos", "astro", "vue", "docker", "nginx", "cloudflare", "tunnels", "hosting", "despliegue"]
image: /blog-images/zimaos-astro-docker-hosting.jpg
gradient: from-cyan-600 to-sky-700
readTime: 14 min
featured: true
---

Si ya tienes [ZimaOS como servidor en casa](/blog/zimaos-servidor-personal-nas) y [Cloudflare Tunnel sin abrir puertos](/blog/zimaos-cloudflare-tunnels), el siguiente paso natural es dejar de “solo guardar archivos” y **publicar un sitio web real** desde ese mismo equipo.

Este post es el proceso concreto: **Astro (o Vue) → `dist/` → imagen Docker con Nginx → contenedor en ZimaOS → hostname en el Tunnel → `https://tu-dominio.com`**.

No es un VPS en la nube. Es tu PC/NAS de casa actuando como hosting estático, con HTTPS limpio detrás de Cloudflare.

---

## Qué vamos a montar

Arquitectura final:

```text
Visitante
   │
   ▼
https://web.tudominio.com     (DNS + HTTPS en Cloudflare)
   │
   ▼
Cloudflare Tunnel             (cloudflared en ZimaOS)
   │
   ▼
http://astro-web:80           (contenedor Nginx en Docker)
   │
   ▼
archivos de dist/             (HTML/CSS/JS de Astro o Vue)
```

Qué ganas con esto:

- Cero pelea con el router (sin port forwarding).
- HTTPS sin certbot en casa.
- Un contenedor fácil de actualizar: rebuild + `docker compose up -d`.
- El mismo patrón sirve para Astro, Vue (Vite), React o cualquier sitio estático.

---

## Requisitos previos

Antes de empezar, ten listo:

1. **ZimaOS** instalado y accesible en la LAN (panel web).
2. **Docker** disponible en ZimaOS (App Store / Docker Compose / terminal).
3. Un **dominio** con DNS en Cloudflare.
4. Un **Tunnel** ya creado y `cloudflared` corriendo en el mismo equipo (o listo para mapear un hostname nuevo). Si aún no, sigue el [post de tunnels](/blog/zimaos-cloudflare-tunnels).
5. En tu laptop de desarrollo: **Node.js** (LTS) y el proyecto Astro/Vue.

Asumo nombres de ejemplo. Cámbialos por los tuyos:

| Concepto | Ejemplo |
|----------|---------|
| Dominio público | `web.tudominio.com` |
| Nombre del contenedor | `astro-web` |
| Puerto en el host (LAN) | `8088` |
| Carpeta en ZimaOS | `/DATA/AppData/astro-web` |

El puerto `8088` es solo para probar dentro de casa. Hacia internet no lo abres: el Tunnel habla al contenedor por la red Docker.

---

## Paso 1: preparar el proyecto (Astro o Vue)

### Astro

En tu máquina de desarrollo:

```bash
# Si aún no tienes proyecto
npm create astro@latest mi-sitio
cd mi-sitio
```

En `astro.config.mjs`, para un sitio en la raíz del dominio (`web.tudominio.com/`), **no** necesitas `base`. Si lo vas a servir en subruta (`tudominio.com/blog/`), sí:

```js
import { defineConfig } from 'astro/config';

export default defineConfig({
  // solo si NO está en la raíz:
  // base: '/blog/',
  output: 'static',
});
```

Build:

```bash
npm install
npm run build
```

Astro deja el sitio listo en `dist/`. Esa carpeta es lo único que Nginx necesita.

### Vue (Vite)

```bash
npm create vite@latest mi-vue -- --template vue
cd mi-vue
npm install
npm run build
```

Vite también genera `dist/`.

**Diferencia importante:** en Vue con Vue Router en modo `history`, las rutas internas (`/about`, `/contacto`) fallan al refrescar si Nginx no hace fallback a `index.html`. Más abajo va la config. En Astro estático puro casi nunca hace falta.

---

## Paso 2: Dockerfile + Nginx (lo que realmente sirve el sitio)

En la raíz del proyecto crea estos archivos.

### `nginx.conf`

```nginx
server {
    listen 80;
    server_name _;
    root /usr/share/nginx/html;
    index index.html;

    # Cache suave para assets hasheados
    location /_astro/ {
        expires 7d;
        add_header Cache-Control "public";
        try_files $uri =404;
    }

    location /assets/ {
        expires 7d;
        add_header Cache-Control "public";
        try_files $uri =404;
    }

    # Astro (páginas reales) o Vue SPA (fallback)
    location / {
        try_files $uri $uri/ /index.html;
    }

    # Seguridad básica
    add_header X-Content-Type-Options nosniff always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;
}
```

`try_files ... /index.html` cubre Vue Router. En Astro, si una ruta no existe, caerá en `index.html` (home). Si prefieres 404 real en Astro, cambia esa línea por:

```nginx
try_files $uri $uri/ =404;
```

y asegúrate de tener `dist/404.html` (Astro lo genera si configuraste página 404).

### `Dockerfile`

```dockerfile
# Etapa 1: build
FROM node:22-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# Etapa 2: servir estático
FROM nginx:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

Ventaja del multi-stage: la imagen final **no** lleva Node ni `node_modules`. Solo Nginx + HTML.

### `.dockerignore`

```text
node_modules
dist
.git
.DS_Store
*.md
.env
.env.*
```

### `docker-compose.yml`

```yaml
services:
  astro-web:
    build: .
    container_name: astro-web
    restart: unless-stopped
    ports:
      # Solo para probar en la LAN. El Tunnel puede ir directo al contenedor.
      - "8088:80"
    networks:
      - webnet

networks:
  webnet:
    name: webnet
```

Si `cloudflared` ya corre en otra compose/red, o bien unes ambas a la misma red Docker, o apuntas el Tunnel a `http://IP-DEL-HOST:8088`. Las dos formas funcionan; la más limpia es red compartida.

---

## Paso 3: llevar el proyecto a ZimaOS

Tienes tres caminos reales. Elige uno.

### Opción A — Build en tu laptop y solo subes `dist/` (más simple)

1. En la laptop: `npm run build`.
2. En ZimaOS crea la carpeta, por ejemplo en el File Manager:  
   `AppData/astro-web/`
3. Sube:
   - contenido de `dist/` → `AppData/astro-web/html/`
   - un `Dockerfile` mínimo solo con Nginx (sin etapa Node):

```dockerfile
FROM nginx:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY html/ /usr/share/nginx/html/
```

4. Sube también `nginx.conf` y este `docker-compose.yml`:

```yaml
services:
  astro-web:
    build: .
    container_name: astro-web
    restart: unless-stopped
    ports:
      - "8088:80"
```

Útil si el mini PC es flojo y no quieres compilar ahí.

### Opción B — Build dentro de ZimaOS (todo en el servidor)

1. Sube el **repo completo** (sin `node_modules`) a `AppData/astro-web/`.
2. Entra por SSH o terminal de ZimaOS:

```bash
cd /DATA/AppData/astro-web
docker compose build
docker compose up -d
```

La primera build tarda (baja Node + dependencias). Las siguientes usan cache.

### Opción C — Solo imagen en un registry

En la laptop:

```bash
docker build -t tu-usuario/astro-web:latest .
docker push tu-usuario/astro-web:latest
```

En ZimaOS el compose queda:

```yaml
services:
  astro-web:
    image: tu-usuario/astro-web:latest
    container_name: astro-web
    restart: unless-stopped
    ports:
      - "8088:80"
```

Bien si ya usas Docker Hub / GHCR.

**Recomendación práctica para empezar:** Opción A o B. La C vale cuando ya automatizas.

---

## Paso 4: levantar el contenedor y probar en la LAN

En ZimaOS (SSH o terminal):

```bash
cd /DATA/AppData/astro-web
docker compose up -d --build
docker ps | grep astro-web
```

Desde otro dispositivo en la misma Wi‑Fi abre:

```text
http://IP-DE-TU-ZIMAOS:8088
```

Si ves el sitio, Nginx está bien. Si ves 403/404:

```bash
docker logs astro-web
docker exec -it astro-web ls -la /usr/share/nginx/html
```

Debes ver `index.html` ahí dentro. Si la carpeta está vacía, el `COPY` del Dockerfile no apuntó a `dist/` correcto (en Vue/Astro a veces el output path cambia).

---

## Paso 5: publicar con Cloudflare Tunnel

Aquí conectas el capítulo anterior.

### En el dashboard de Cloudflare Zero Trust

1. Entra a **Networks → Tunnels**.
2. Abre tu tunnel (el mismo de Jellyfin u otros servicios).
3. **Public Hostname** → Add:

| Campo | Valor |
|-------|--------|
| Subdomain | `web` |
| Domain | `tudominio.com` |
| Type | `HTTP` |
| URL | ver abajo |

### Qué poner en URL (elige según cómo corre cloudflared)

**Caso 1 — `cloudflared` en Docker, misma red que `astro-web`:**

```text
http://astro-web:80
```

Para que resuelva el nombre, ambos contenedores deben compartir red. Ejemplo mínimo uniendo redes:

```yaml
# en el compose de cloudflared, o crea una red externa
networks:
  webnet:
    external: true
```

y en el servicio `cloudflared`:

```yaml
networks:
  - webnet
```

**Caso 2 — `cloudflared` en el host / no comparte red Docker:**

```text
http://172.17.0.1:8088
```

o la IP LAN del ZimaOS:

```text
http://192.168.1.50:8088
```

(usa la IP real de tu red).

**Caso 3 — cloudflared en el mismo `docker-compose.yml`:**

```yaml
services:
  astro-web:
    build: .
    container_name: astro-web
    restart: unless-stopped
    networks:
      - webnet

  cloudflared:
    image: cloudflare/cloudflared:latest
    container_name: cloudflared
    restart: unless-stopped
    command: tunnel --no-autoupdate run --token TU_TOKEN
    networks:
      - webnet

networks:
  webnet:
```

Entonces el Public Hostname apunta a `http://astro-web:80` y **puedes quitar** el `ports: "8088:80"` si no necesitas acceso LAN directo.

### Probar desde fuera

1. Desconecta Wi‑Fi del celular (usa datos).
2. Abre `https://web.tudominio.com`.
3. Si carga: listo. Cloudflare termina TLS; tu casa solo hizo conexiones de salida.

DNS: Cloudflare suele crear el CNAME del hostname al tunnel automáticamente. Si no, crea el registro CNAME `web` → `xxxxx.cfargotunnel.com` (proxied).

---

## Paso 6: actualizar el sitio (flujo diario real)

Cuando cambias contenido:

```bash
# en la laptop
git pull   # o editas local
npm run build
```

### Si usas Opción A (solo `dist/`)

1. Sube de nuevo los archivos de `dist/` a `AppData/astro-web/html/`.
2. Reinicia Nginx (no hace falta rebuild si solo montas volumen):

Mejor aún: monta el HTML como volumen y evitas rebuilds:

```yaml
services:
  astro-web:
    image: nginx:1.27-alpine
    container_name: astro-web
    restart: unless-stopped
    ports:
      - "8088:80"
    volumes:
      - ./html:/usr/share/nginx/html:ro
      - ./nginx.conf:/etc/nginx/conf.d/default.conf:ro
```

Así actualizas: **copias `dist/` → `html/`** y listo. A veces hace falta:

```bash
docker exec astro-web nginx -s reload
```

### Si usas Opción B (build en el servidor)

```bash
cd /DATA/AppData/astro-web
git pull
docker compose up -d --build
```

### Tip de cache

Cloudflare y el navegador cachean assets. Si “no veo el cambio”, prueba ventana privada o en Cloudflare: Caching → Purge Cache del hostname.

---

## Extra: deploy automático desde GitHub (opcional)

Cuando te canses de copiar a mano, un workflow simple:

1. Push a `main`.
2. GitHub Actions hace `npm run build`.
3. Sube `dist/` por `scp`/`rsync` al ZimaOS (o construye y pushea la imagen).

Esqueleto de idea (no copies ciego; ajusta secretos y rutas):

```yaml
# .github/workflows/deploy-zimaos.yml
name: Deploy to ZimaOS
on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
          cache: npm
      - run: npm ci && npm run build
      - name: Upload dist
        uses: appleboy/scp-action@v0.1.7
        with:
          host: ${{ secrets.ZIMA_HOST }}
          username: ${{ secrets.ZIMA_USER }}
          key: ${{ secrets.ZIMA_SSH_KEY }}
          source: "dist/*"
          target: "/DATA/AppData/astro-web/html"
          strip_components: 1
```

`ZIMA_HOST` puede ser una IP solo alcanzable por VPN, o un hostname interno vía otro tunnel SSH. **No expongas SSH a internet abierto** solo por comodidad; si lo haces, restringe IPs y usa llaves.

Para muchos proyectos personales, copiar `dist/` a mano una vez por semana alcanza.

---

## Errores frecuentes (y cómo se ven)

| Síntoma | Causa típica | Qué mirar |
|---------|--------------|-----------|
| 502 Bad Gateway en Cloudflare | Tunnel apunta mal | URL del Public Hostname; `docker ps`; red Docker |
| Sitio vacío / 403 | `dist/` no copiado | `ls` dentro del contenedor en `/usr/share/nginx/html` |
| CSS roto / rutas 404 | `base` mal en Astro | `astro.config.mjs` y links absolutos |
| Vue: refresh en `/about` da 404 | falta fallback SPA | `try_files ... /index.html` en Nginx |
| Funciona en LAN, no fuera | hostname/DNS | CNAME proxied; tunnel online en Zero Trust |
| Funciona un rato y muere | contenedor sin `restart` | `restart: unless-stopped` |
| Build OOM en ZimaOS | RAM corta | Opción A: build en laptop |

Logs útiles:

```bash
docker logs astro-web --tail 100
docker logs cloudflared --tail 100
```

---

## Qué NO meter por este camino (aún)

Este patrón es para **front estático** (Astro SSG, Vue SPA build, landing, portafolio, docs).

Si tu Astro usa `output: 'server'` (SSR) o un API Node/Laravel:

- necesitas otro contenedor (Node, PHP-FPM, etc.),
- variables de entorno,
- y el Tunnel apunta a ese servicio, no solo a Nginx de archivos.

Se puede. Es otro post. Empieza estático: menos piezas, menos dolor.

Tampoco publiques paneles de admin del NAS por el mismo hostname “porque ya está el tunnel”. Un sitio de marketing ≠ panel de ZimaOS.

---

## Checklist final

- [ ] `npm run build` genera `dist/` con `index.html`
- [ ] Contenedor Nginx sirve en `http://IP:8088` dentro de casa
- [ ] Public Hostname del Tunnel → contenedor o `IP:8088`
- [ ] Prueba desde datos móviles
- [ ] `restart: unless-stopped` en el compose
- [ ] Sabes cómo volver a subir `dist/` cuando cambies el sitio

---

## Conclusión

Hospedar Astro o Vue en ZimaOS no es “instalar un hosting mágico”. Es un pipeline corto y repetible:

1. Build estático.  
2. Nginx en Docker.  
3. Contenedor siempre arriba en ZimaOS.  
4. Cloudflare Tunnel hacia ese contenedor.  

Con eso tu PC viejo o mini NAS deja de ser solo almacenamiento y pasa a ser **infraestructura de deploy** sin factura de VPS ni puertos abiertos en el router.

Si vienes de cero, el orden de la serie ayuda:

1. [ZimaOS como NAS/servidor](/blog/zimaos-servidor-personal-nas)  
2. [Cloudflare Tunnels](/blog/zimaos-cloudflare-tunnels)  
3. **Este post:** publicar el sitio  

Cuando esto esté estable, el siguiente salto natural es automatizar el `dist/` desde GitHub… o meter un backend en otro contenedor. De a una pieza.
