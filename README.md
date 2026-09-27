# Sistema de Gestión de Mantenimiento de Equipos

Trabajo Final Integrador — Tecnicatura Universitaria en Programación (UTN)

**Integrantes:** Matías Orellana, Nicolás Pagola
**Grupo:** 178
**Tutor:** Oscar Londero
**Repositorio:** https://github.com/notvo-1/fleet-maintenance-system

## 1. Definición del problema

### 1.1 Actores involucrados

- Operarios y personal de obra: registran el uso diario de los equipos (horómetro/kilometraje) y reportan novedades (fallas, servicios realizados).
- Analistas de mantenimiento: consolidan la información recibida desde las distintas obras, determinan el estado de cada equipo y arman los reportes de gestión.
- Gerencia / control de gestión: consume los reportes de disponibilidad, costos y desempeño para decidir si conviene mantener, reparar o dar de baja una unidad.

### 1.2 Problema central

Hoy en Cartellone el control de equipos y maquinaria de obra (estado, horómetros, historial de mantenimientos) se gestiona de forma prácticamente manual, principalmente en planillas Excel que se completan y consolidan a mano desde distintas obras. Existe un software de gestión pero no se amolda enteramente a las necesidades de la empresa. Este proceso es lento, propenso a errores, como equipos fuera de servicio sin marcar a tiempo, datos duplicados o inconsistentes entre fuentes, y no permite un seguimiento ágil del uso, disponibilidad mecánica ni costos por equipo.

El impacto es concreto: la consolidación mensual de datos de cientos de equipos distribuidos en múltiples obras a lo largo de Argentina, con distintos tipos de grupos profesionales, insume varias horas de trabajo manual recurrentes, y las decisiones de mantener, reparar o vender una unidad muchas veces se toman sin un análisis consolidado y actualizado de su historial real de uso y costos.

Otro aspecto que la solución informática no contempla hoy es la vida útil real que tiene el equipo. Esto se sostiene hoy mediante una tabla Excel, porque el equipo puede sufrir cambios de horómetro/odómetro y la cuenta real de la "edad" del equipo se pierde al mantener solo la lectura actual.

### 1.3 Valor agregado de la solución

El diferencial no pasa solo por "digitalizar" la planilla actual, sino por:

- Reportes de gestión (disponibilidad, costos, próximos mantenimientos) generados automáticamente, hoy armados a mano.
- Una vía de carga masiva y periódica de datos mediante templates, pensada para obras que no cargan partes diarios de forma continua, reduciendo la carga manual actual.
- Asistencia de IA (etapa posterior del proyecto) para detectar datos cargados que "no tienen sentido" — por ejemplo, saltos de horómetro incoherentes — y marcarlos para revisión, en lugar de aceptarlos sin control.
- Mantener un Historial de Equipo que permita saber el recorrido del equipo en los diferentes proyectos, su aporte productivo, el costo en cada proyecto y la utilidad remanente del equipo teniendo en cuenta el horómetro acumulado.

## 2. Alcance del proyecto (MVP)

### 2.1 Incluido en la primera versión

- Gestión de equipos (alta, tipo, estado actual).
- Gestión de obras/proyectos y movimientos de equipos entre obras.
- Carga de mediciones: registro individual de horómetro/km por equipo y fecha, vía formulario web.
- Carga masiva de medidores: importación de mediciones por equipo y fecha a partir de una planilla template completada por los proyectos, pensada para equipos que no cargan por la app directamente.
- Registro de mantenimientos/servicios realizados por equipo.
- Cálculo automático de estado (activo / fuera de servicio) e indicadores básicos de uso.
- Reportes y vista de historial por equipo.
- Usuarios con roles básicos (operador / analista).
- Historial de equipo: registro del recorrido por obras, aporte productivo y costos asociados.

### 2.2 Explícitamente fuera de alcance en el MVP

- Validación de cargas asistida por IA — queda como objetivo extendido, condicionado al tiempo disponible.
- Aplicación móvil nativa — el frontend web cubre el MVP.

## 3. Stack tecnológico

| Componente | Tecnología elegida |
| --- | --- |
| Frontend | Vite + TypeScript + React |
| Backend | .NET 10 (ASP.NET Core Web API) + Entity Framework Core |
| Base de datos | PostgreSQL |
| Despliegue | Backend en Render/Railway · DB en Supabase o Aiven · Frontend en Vercel |

### 3.1 Justificación

**Frontend:** se eligió TypeScript con Vite por ser la tecnología con la que el equipo se siente más cómodo tras la cursada, lo que reduce el costo de aprendizaje en un proyecto con fecha de entrega fija.

**Backend:** .NET con Entity Framework Core es la tecnología que uno de los integrantes viene formando activamente mediante cursos externos, y encaja bien con la naturaleza del problema: los datos del dominio tienen una estructura relacional clara, con relaciones importantes entre entidades e integridad transaccional necesaria. Se eligió la versión LTS vigente (.NET 10) para asegurar soporte durante todo el desarrollo y hasta después de la entrega final.

**Base de datos:** se eligió PostgreSQL por su buen soporte en EF Core, su facilidad de despliegue en servicios con capa gratuita y por ser una opción neutral respecto del proveedor, sin atar el proyecto exclusivamente al ecosistema Microsoft.

**Despliegue:** se optó por servicios PaaS con capa gratuita, ya que reducen la complejidad operativa y se ajustan al requisito de la cátedra de tener el proyecto accesible online, sin necesidad de administrar infraestructura propia.

### 3.2 Escalabilidad

El escenario real del proyecto es de uso interno por parte de un número acotado de usuarios, no miles de usuarios concurrentes. El stack elegido es suficiente para ese volumen.

## 4. Riesgos identificados y mitigación

| Riesgo | Mitigación |
| --- | --- |
| Curva de aprendizaje en EF Core, ya que aún en formación | Definir el modelo de datos de forma temprana y priorizar funcionalidades core sobre features avanzadas |
| Alcance de IA para validación de datos puede demandar más tiempo del disponible | Tratarla como objetivo extendido, no bloqueante para el MVP |
| Uso de datos reales de la empresa en la demo/informe | Anonimizar los datos o construir un dataset ficticio equivalente para la entrega pública |
| Disponibilidad de tiempo del equipo | Alcance de MVP acotado y priorizado por entregas parciales |

## Documentación adicional

- [Esquema de base de datos](./docs/esquema-bd.md) — modelo relacional, tablas y decisiones de diseño.
- [Listado de módulos](./docs/modulos.md) — módulos del sistema para el MVP.

## 5. Cronograma

| Instancia | Fecha límite | Contenido |
| --- | --- | --- |
| Entrega 1 | 30/08 | Propuesta de proyecto, stack tecnológico y repositorio GitHub |
| Entrega 2 | 27/09 | Esquema de base de datos y listado de módulos (condición de regular) |
| Entrega final | 14/11 | Repositorio completo, despliegue online, informe y video explicativo |
| Defensa oral | A definir | Presentación y justificación ante el comité |
