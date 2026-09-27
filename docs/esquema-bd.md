# Esquema de base de datos

Modelo relacional (PostgreSQL) para el Sistema de Gestión de Mantenimiento de Equipos.

Script DDL completo: [`schema.sql`](./schema.sql)

## Tablas y relaciones

| Tabla | Descripción | Se relaciona con |
| --- | --- | --- |
| `obras` | Obras/proyectos de la empresa | `equipos`, `movimientos` |
| `equipos` | Maquinaria y equipos de obra | `movimientos`, `mediciones`, `mantenimientos`, `estados_historial`, `cambios_medidor` |
| `movimientos` | Traslados de un equipo entre obras | `equipos`, `obras` |
| `mediciones` | Lecturas de horómetro/km por equipo y fecha | `equipos`, `usuarios`, `cargas_masivas` |
| `cargas_masivas` | Registro de cada importación por planilla template | `usuarios`, `mediciones` |
| `mantenimientos` | Servicios/mantenimientos realizados por equipo | `equipos` |
| `estados_historial` | Historial de estado (activo / fuera de servicio) por equipo | `equipos` |
| `cambios_medidor` | Registro de reemplazos de medidor físico, para reconstruir el acumulado real de uso del equipo | `equipos` |
| `usuarios` | Usuarios del sistema (operador / analista) | `mediciones`, `cargas_masivas` |

## Decisiones de diseño

- **`estados_historial` en vez de un campo único de estado**: se necesita saber cuándo un equipo entró y salió de "fuera de servicio", no solo su estado actual — esto ya era un problema real detectado en la propuesta (equipos FS sin marcar a tiempo).
- **`cambios_medidor` como tabla aparte**: cuando se reemplaza el horómetro físico de un equipo, la lectura vuelve a cero. Sin este registro se pierde la cuenta del uso acumulado real (vida útil), que es uno de los problemas identificados en la propuesta original que el software actual no resuelve.
- **`mediciones.origen` y `cargas_masivas`**: una medición puede cargarse individualmente por formulario o en lote desde una planilla template subida por los proyectos — ambas vías alimentan la misma tabla, diferenciadas por el campo `origen`.
- **No hay tabla de "historial de equipo"**: esa vista se construye combinando `movimientos` + `mediciones` + `mantenimientos` por equipo; no necesita su propia tabla.
