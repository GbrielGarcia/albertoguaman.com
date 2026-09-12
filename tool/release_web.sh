#!/usr/bin/env bash
# Build de producción web + checklist para Hostinger (public_html).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "==> flutter pub get"
flutter pub get

echo "==> flutter gen-l10n"
flutter gen-l10n

echo "==> flutter build web --release"
flutter build web --release --no-wasm-dry-run

echo "==> sync .htaccess → build/web"
cp -f web/.htaccess build/web/.htaccess

echo
echo "✓ Listo: $ROOT/build/web"
echo
echo "Checklist Hostinger (public_html):"
echo "  [ ] Subir TODO el contenido de build/web/"
echo "  [ ] Confirmar .htaccess en la raíz de public_html"
echo "  [ ] Probar https://albertoguaman.com/blog y /blog/"
echo "  [ ] Probar https://albertoguaman.com/cv y /casos"
echo "  [ ] Probar https://albertoguaman.com/blog/rss.xml"
echo "  [ ] Si hay PDFs de CV, estánificar /cv/*.pdf"
echo
echo "Opcional: regenerar RSS → python3 tool/generate_rss.py"
