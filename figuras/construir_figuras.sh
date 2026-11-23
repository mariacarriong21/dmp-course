#!/bin/sh
# ------------------------------------------------------------------
# Compila las figuras del curso C1 y genera los PNG.
#
#   ./construir_figuras.sh
#
# Cada figura es un .tex independiente (clase standalone) que produce
# un PDF recortado al contenido. De ahí sale el PNG a 220 ppp, que es
# lo que se inserta en los materiales y lo que se sube a la plataforma.
# ------------------------------------------------------------------
set -e
cd "$(dirname "$0")"
DPI=220
mkdir -p png

for f in f?_*.tex; do
    b="${f%.tex}"
    printf '%-28s' "$b"
    pdflatex -interaction=nonstopmode "$f" >/dev/null 2>&1 || true
    if [ ! -f "$b.pdf" ]; then
        echo "FALLO — revisar $b.log"
        continue
    fi
    pdftoppm -png -r "$DPI" -singlefile "$b.pdf" "png/$b"
    printf 'PDF + PNG  (%s)\n' "$(du -h "png/$b.png" | cut -f1 | tr -d ' ')"
done

rm -f ./*.aux ./*.log
echo "--------------------------------------------------"
echo "PNG en $(pwd)/png"
