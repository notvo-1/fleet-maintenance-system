# Módulos del proyecto

## 1. Gestión de equipos y obras
Alta y consulta de equipos (tipo, estado actual, obra asignada) y de obras/proyectos.

## 2. Movimientos
Registro del traslado de un equipo entre obras, con fecha. Base del historial de recorrido por proyecto.

## 3. Mediciones
Carga de lecturas de horómetro/km por equipo y fecha, por dos vías:
- **Individual**: formulario web, carga puntual.
- **Carga masiva**: importación desde una planilla template completada por los proyectos, pensada para equipos que no cargan datos de forma continua por la app.

## 4. Mantenimientos
Registro de servicios y mantenimientos realizados por equipo, con tipo, fecha y costo asociado.

## 5. Estados y alertas
Cálculo y seguimiento del estado de cada equipo (activo / fuera de servicio), con historial de cuándo entró y salió de cada estado.

## 6. Reportes e historial de equipo
Vistas y reportes que combinan movimientos, mediciones y mantenimientos por equipo: recorrido por obras, uso acumulado real (contemplando cambios de medidor), costos y disponibilidad.

## 7. Usuarios y roles
Gestión de usuarios del sistema con roles básicos: operador (carga de datos) y analista (gestión y reportes).

## Fuera de alcance en el MVP
- Validación de cargas asistida por IA (objetivo extendido, condicionado al tiempo disponible).
- Aplicación móvil nativa.
