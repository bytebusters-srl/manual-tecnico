# Configuración global de compilación para LaTeX

# 1. Enviar toda la basura y el PDF final a la carpeta build/
$out_dir = 'build';

# 1b. Espejar la estructura de sections/ dentro de build/ ANTES de compilar.
# Sin esto, pdflatex con -output-directory no encuentra los subdirectorios
# build/sections/capNN y deja los .aux sueltos junto al fuente.
#
# IMPORTANTE: se enumeran los subdirectorios de forma EXPLÍCITA en lugar de
# recorrer 'sections/' con File::Find. El recorrido recursivo terminaba
# encontrando las carpetas ya espejadas y concatenaba 'build/sections/build/
# sections/...' hasta el error "File name too long". Las rutas explícitas son
# idempotentes: make_path no falla si el directorio ya existe.
use File::Path qw(make_path);
foreach my $sub (qw(
    front cap01 cap02 cap03 cap04 cap05 cap06 cap07 cap08 cap09
)) {
    make_path("$out_dir/sections/$sub");
}

# 2. Forzar la compilación en PDF usando pdflatex
$pdf_mode = 1;

# 2b. Permitir más pasadas: longtable + lastpage requieren iteraciones extra
# para estabilizar la paginación y las referencias \pageref{LastPage}.
$max_repeat = 7;

# 3. Comandos activados (-shell-escape es vital para el paquete minted).
# Nota: se omite -file-line-error porque, combinado con longtable/lastpage,
# provoca que pdflatex devuelva un código de salida no-cero durante las pasadas
# de "rerun", confundiendo la heurística de convergencia de latexmk.
# IMPORTANTE — Normalización del código de salida de pdflatex.
# Con longtable + lastpage (\pageref{LastPage} en \end{document}), pdflatex en
# modo nonstopmode ESCRIBE el PDF correctamente pero devuelve código 1 mientras
# queda pendiente un "Rerun to get references right". latexmk CACHEA ese código
# en build/main.fdb_latexmk y lo propaga como 12 en TODAS las compilaciones
# siguientes —incluso "Nothing to do"—. LaTeX Workshop lo lee como "fallo" y NO
# refresca el visor: ese es exactamente el síntoma "guardo y no veo cambios ni
# índice".
#
# Solución: envolver pdflatex de modo que, si el PDF terminó escribiéndose
# ("Output written on"), el wrapper devuelva 0. Los errores LaTeX reales (que NO
# escriben PDF) siguen devolviendo != 0 y se siguen reportando con normalidad.
$pdflatex = 'internal mypdflatex %O %S';
sub mypdflatex {
    my @args = @_;
    my $ret = system('pdflatex', '-interaction=nonstopmode',
                     '-synctex=1', '-shell-escape', @args);
    # Localizar el .log de esta compilación para confirmar que hubo salida PDF.
    my $base = $args[-1];
    $base =~ s/\.tex$//;
    $base =~ s{.*/}{};
    my $log = "$out_dir/$base.log";
    if ($ret != 0 && -e $log) {
        open(my $fh, '<', $log) or return $ret;
        local $/; my $content = <$fh>; close($fh);
        # Si el PDF se escribió, el fallo es solo el "rerun" pendiente: éxito.
        return 0 if $content =~ /Output written on/;
    }
    return $ret;
}

# 4. Archivos adicionales que debe borrar cuando ejecutemos el comando de "limpieza"
$clean_ext = 'aux out log toc bbl blg synctex.gz fls fdb_latexmk vrb snm nav run.xml bcf pyg _minted*';
