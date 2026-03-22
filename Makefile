# Atajos para compilar el documento LaTeX

# Variables
DOCNAME = main      	# Nombre del documento (sin extensión .tex)
BUILDDIR = build		# Carpeta donde se guardarán los archivos generados

.PHONY: all clean watch

# Atajo 1: 'make' o 'make all' -> Compila el documento
all:
	latexmk $(DOCNAME).tex

# Atajo 2: 'make clean' -> Borra la carpeta build y el caché de minted
clean:
	latexmk -c
	rm -rf $(BUILDDIR)/*
	rm -rf _minted-$(DOCNAME)

# Atajo 3: 'make watch' -> Se queda escuchando. Si guardas un cambio, compila solo.
watch:
	latexmk -pvc $(DOCNAME).tex