#!/bin/sh
# Genera los descargables del curso en formato editable a partir de los .md
# derivados de c1_materiales.tex. No se editan a mano: se regeneran.
set -e
cd "$(dirname "$0")"
M=../materiales/04_documentos
gen() {  # $1 fichero .md  $2 salida .docx  $3 título
    pandoc "$M/$1" -o "$2" --metadata title="$3" --toc=false 2>/dev/null
    printf '  %-42s %s\n' "$2" "$(du -h "$2" | cut -f1 | tr -d ' ')"
}
gen 02_plantilla-de-pgd.md             c1_plantilla_pgd.docx          "Plantilla de plan de gestión de datos"
gen 05_guia-de-redaccion.md            c1_guia_de_redaccion.docx      "Guía de redacción"
gen 06_lista-de-comprobacion-y-rubrica.md c1_lista_de_comprobacion.docx "Lista de comprobación y rúbrica"
gen 01_tabla-de-inventario.md          c1_inventario_instrucciones.docx "Tabla de inventario · instrucciones"
