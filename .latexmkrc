# Configuración global de compilación para LaTeX

# 1. Enviar toda la basura y el PDF final a la carpeta build/
$out_dir = 'build';

# 2. Forzar la compilación en PDF usando pdflatex
$pdf_mode = 1; 

# 3. Comandos activados (-shell-escape es vital para el paquete minted)
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 -file-line-error -shell-escape %O %S';

# 4. Archivos adicionales que debe borrar cuando ejecutemos el comando de "limpieza"
$clean_ext = 'aux out log toc bbl blg synctex.gz fls fdb_latexmk vrb snm nav run.xml bcf pyg _minted*';