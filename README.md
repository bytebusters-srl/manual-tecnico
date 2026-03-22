# Plantilla de Manual Técnico - Estándar ISO/IEC/IEEE 15289:2024 & IEEE 830

## Logo
![Logo Byte Busters](assets/img/bytebusters/logo_horizontal.png)

## Insignias
[![LaTeX](https://img.shields.io/badge/LaTeX-Project-008080.svg?style=flat&logo=latex&logoColor=white)](https://www.latex-project.org/)
[![License: CC0-1.0](https://img.shields.io/badge/License-CC0_1.0-lightgrey.svg)](http://creativecommons.org/publicdomain/zero/1.0/)
[![Standard: ISO 15289](https://img.shields.io/badge/Standard-ISO/IEC/IEEE_15289-blue)](https://www.iso.org/standard/83674.html)

## Perfil de Github - Introducción
Este repositorio proporciona una infraestructura técnica en **LaTeX** diseñada para generar manuales técnicos y de arquitectura de software que cumplan estrictamente con los estándares internacionales **ISO/IEC/IEEE 15289:2024** e **IEEE 830**. Está optimizado para los equipos de ingeniería de la empresa **Byte Busters S.R.L.** en el marco de la Facultad de Ciencias y Tecnología de la UMSS.

## Características
* **Cumplimiento Normativo (Ingeniería):** Implementa la estructura de contenido para Arquitectura, APIs y Mantenimiento exigida por la norma ISO.
* **Identidad Visual y Técnica:** Tipografías corporativas preconfiguradas (Helvetica para títulos, Times para cuerpo y Courier New para lectura intensiva de código).
* **Diseño de Layout:** Márgenes exactos de 3cm (interno) y 2cm (externo) con interlineado de 1.5, optimizado para trazabilidad e impresión de manuales extensos.
* **Componentes Especializados:** Macros visuales para Diccionarios de Datos, Alertas de Seguridad, Notas Técnicas y Checklists de Despliegue.
* **Gestión de Compilación:** Redirección automática de archivos auxiliares a la carpeta `/build` para mantener el directorio limpio.

## Tecnología
* **Lenguaje de Marcado:** LaTeX.
* **Motor de Compilación:** `pdflatex` con soporte interactivo y `minted` mediante `-shell-escape`.
* **Automatización:** `latexmk` para gestión de dependencias y `Makefile` para atajos de terminal.
* **Editor Sugerido:** Visual Studio Code con extensión *LaTeX Workshop*.

## Perfil de Github - Habilidades
* **Software Architecture Documentation:** ISO/IEC/IEEE 15289:2024.
* **Requirements Specification:** IEEE 830.
* **Typesetting:** LaTeX, BibTeX.
* **Project Management:** Estructura técnica organizada para Taller de Ingeniería de Software (TIS).

## Instalación
Para utilizar esta plantilla localmente, clona el repositorio y asegúrate de tener una distribución de LaTeX instalada (TeX Live o MiKTeX):

```bash
git clone [https://github.com/dpardo23/manual-usuario.git](https://github.com/dpardo23/manual-usuario.git)
cd manual-usuario
```

## Corre Localmente
Utiliza el `Makefile` o `latexmk` incluido para gestionar el ciclo de vida del documento:

```bash
# Compilar el manual técnico completo
latexmk -pdf -outdir=build main.tex 

# Limpiar archivos temporales y la carpeta build
make clean
```

## Ejecutando Pruebas
Para validar que el entorno está correctamente configurado (especialmente el paquete `minted` y el motor `pdflatex`), ejecute:
1. `make clean`
2. `make all`
3. Verifique la existencia del PDF en `build/main.pdf`.

## Uso/Ejemplos
La plantilla incluye componentes especiales de ingeniería para documentar componentes de software:

```latex
\begin{NotaTecnica}
El núcleo del procesador asíncrono tiene una alta dependencia en las colas de mensajes. Modificar este componente requiere reconstruir los contenedores.
\end{NotaTecnica}

\begin{AlertaSeguridad}
Nunca exponga los archivos de configuración de entorno (.env) en repositorios públicos. Asegúrese de rotar las llaves API cada 90 días.
\end{AlertaSeguridad}

\begin{TablaAPI}
user_id & Integer & Identificador único del usuario en DB & 1024 \\
\hline
auth_token & String (JWT) & Token de sesión para autorización & eyJhbGci... \\
\hline
\end{TablaAPI}
```

## Variables de Entorno
La configuración del flujo de trabajo se define en `.latexmkrc`:
* `$out_dir = 'build'`: Todos los binarios y archivos temporales se guardan aquí.
* `$pdf_mode = 1`: Fuerza la generación de salida en formato PDF.

## Capturas de Pantalla
El diseño final respeta los siguientes estándares de identidad corporativa y trazabilidad:
* **Encabezados Dinámicos:** Logo de Byte Busters S.R.L. (Izq) y Nombre del Módulo/Capítulo actual junto a su Estado de Aprobación (Der).
* **Pie de Página:** Versión Semántica e IP de Confidencialidad (Izq) y Paginación dinámica (Der).
* **Colores Semánticos:** Azul Corporativo (#080852) para elementos primarios, Rojo para Vulnerabilidades y Gris Técnico para bloques de código.

## Documentación
El documento maestro (`main.tex`) está dividido en las secciones obligatorias del estándar:
* **Historial de Revisiones:** Trazabilidad de versiones y roles (SME).
* **Identificación del Sistema:** Stack tecnológico base.
* **Arquitectura del Sistema:** Diagramas de componentes y modelo de datos.
* **Requerimientos (IEEE 830):** Interfaces externas y atributos de calidad.
* **Estructura del Código:** Módulos principales y convenciones.
* **APIs y Servicios:** Endpoints y diccionario de datos.
* **Mantenimiento y Diagnóstico:** Logs, backups y procedimientos de despliegue.

## Hoja de Ruta
* [ ] Implementación nativa de diagramas de arquitectura usando el paquete TikZ.
* [ ] Integración automática de logs de Git al Historial de Revisiones.
* [ ] Plantilla base para documentación de endpoints bajo estándar OpenAPI/Swagger exportado a LaTeX.

## Optimizaciones
* **Marcas Dinámicas:** Uso de `\leftmark` para inyectar automáticamente el nombre del capítulo actual en los encabezados.
* **SyncTeX:** Habilitado para navegación bidireccional entre el código fuente y el PDF generado.
* **Tablas Autoajustables:** Implementación de `tabularx` para diccionarios de datos dinámicos.

## Relacionado
* Sitio Oficial de la Empresa TIS
* Guía de Estilo ISO/IEC/IEEE 15289:2024

## FAQ

**¿Por qué recibo el error `Undefined control sequence. \tcbtitletext -> \faShieldAlt`?**
Asegúrese de usar `\faShield*` o `\faIcon{shield-alt}` si la versión de su paquete `fontawesome5` está desactualizada.

**¿Cómo cambio el nombre del PDF de salida?**
Modifique la variable `DOCNAME` en el archivo `Makefile`.

## Lecciones
Durante el desarrollo de esta plantilla se priorizó la separación de intereses, moviendo toda la lógica de diseño y macros de ingeniería a la carpeta `/config` para que el desarrollador solo deba preocuparse por documentar el código y la arquitectura en `/sections`.

## Autores
* **Razón Social:** Byte Busters S.R.L.
* **Representante Legal:** Juan Diego Pardo Pozo
* **Consultor TIS:** Corina Justina Flores Villarroel

## Feedback y Apoyo
Para reportar errores o solicitar soporte técnico, escriba a: contacto.bytebusters@gmail.com.

## Licencia
Este proyecto se distribuye bajo la licencia CC0 1.0 Universal (Public Domain Dedication). Puedes copiar, modificar y distribuir el trabajo, incluso con fines comerciales, sin pedir permiso.
