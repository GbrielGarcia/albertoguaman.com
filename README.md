# albertoguaman.com

Portafolio multiplataforma (Flutter) de Alberto Guaman.

Sitio en producción: https://albertoguaman.com

## Desarrollo

```bash
flutter pub get
flutter gen-l10n
flutter run -d chrome -t lib/main.dart
```

## Build de producción (web)

Opción recomendada:

```bash
chmod +x tool/release_web.sh
./tool/release_web.sh
```

Equivale a `flutter build web --release` y deja el artefacto en `build/web/`, con `.htaccess` sincronizado.

### Deploy en Hostinger

Sube **todo** el contenido de `build/web/` a:

`/domains/albertoguaman.com/public_html`

Checklist:

1. Confirmar que `public_html/.htaccess` es el del repo (rutas SPA).
2. Probar `/blog`, `/blog/`, `/casos`, `/cv`, `/recomendaciones`, `/contacto`.
3. Probar archivo real: `/blog/rss.xml` y PDFs en `/cv/*.pdf`.

El `.htaccess` reescribe `/blog` y `/cv` a `index.html` porque esas carpetas existen en disco (RSS / PDFs) y sin la regla Apache responde **403**.

## CVs

| Archivo | Uso |
|---|---|
| `web/cv/2026_cv_st.pdf` | CV **principal** (Soporte / Técnico) — enlace del sitio |
| `web/cv/cv_sep_agg_2026.pdf` | Copia / variante agregada |

El sitio está en **español** únicamente.

## Blog / RSS

Posts: `assets/blog/posts/` + catálogo en `lib/src/model/blog_post.dart`.

Regenerar feed:

```bash
python3 tool/generate_rss.py
```

## Analytics

Plausible (privacy-friendly) está enganchado en `web/index.html` para `albertoguaman.com`. Si no usas Plausible, elimina el `<script>` correspondiente.
