# Atajos para compilar el documento LaTeX

# Variables
# Nombre del documento (sin extensión .tex)
DOCNAME = main
# Carpeta donde se guardarán los archivos generados
BUILDDIR = build

.PHONY: all clean watch prepare

# Crea el espejo de 'sections/' dentro de build/ para que \include pueda
# escribir los .aux por sección (requerido al usar $out_dir = build).
prepare:
	mkdir -p $(BUILDDIR)/sections/front
	mkdir -p $(BUILDDIR)/sections/cap01
	mkdir -p $(BUILDDIR)/sections/cap02
	mkdir -p $(BUILDDIR)/sections/cap03
	mkdir -p $(BUILDDIR)/sections/cap04
	mkdir -p $(BUILDDIR)/sections/cap05
	mkdir -p $(BUILDDIR)/sections/cap06
	mkdir -p $(BUILDDIR)/sections/cap07
	mkdir -p $(BUILDDIR)/sections/cap08
	mkdir -p $(BUILDDIR)/sections/cap09

# Atajo 1: 'make' o 'make all' -> Compila el documento.
# Se ejecuta pdflatex un número fijo de pasadas (5) en lugar de latexmk:
# la combinación longtable + lastpage repagina entre pasadas y la heurística
# de convergencia de latexmk aborta antes de estabilizar \pageref{LastPage}.
# Cinco pasadas garantizan TOC, longtables y referencias cruzadas estables.
PDFLATEX = pdflatex -interaction=nonstopmode -synctex=1 -shell-escape -output-directory=$(BUILDDIR)

# El prefijo '-' ignora el código de salida: pdflatex en nonstopmode devuelve 1
# mientras haya referencias por resolver, aunque el PDF se genere correctamente.
all: prepare
	-$(PDFLATEX) $(DOCNAME).tex
	-$(PDFLATEX) $(DOCNAME).tex
	-$(PDFLATEX) $(DOCNAME).tex
	-$(PDFLATEX) $(DOCNAME).tex
	-$(PDFLATEX) $(DOCNAME).tex
	@echo "PDF generado en $(BUILDDIR)/$(DOCNAME).pdf"

# Atajo 2: 'make clean' -> Borra la carpeta build y el caché de minted
clean:
	latexmk -c
	rm -rf $(BUILDDIR)/*
	rm -rf _minted-$(DOCNAME)

# Atajo 3: 'make watch' -> Se queda escuchando. Si guardas un cambio, compila solo.
watch: prepare
	latexmk -pvc $(DOCNAME).tex