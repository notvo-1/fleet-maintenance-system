-- Sistema de Gestión de Mantenimiento de Equipos
-- Esquema de base de datos - Entrega 2 (TFI)

CREATE TABLE usuarios (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    rol VARCHAR(20) NOT NULL CHECK (rol IN ('operador', 'analista'))
);

CREATE TABLE obras (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(150) NOT NULL,
    activa BOOLEAN NOT NULL DEFAULT true
);

CREATE TABLE equipos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    codigo VARCHAR(50) UNIQUE NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    obra_actual_id UUID REFERENCES obras(id),
    estado_actual VARCHAR(20) NOT NULL CHECK (estado_actual IN ('activo', 'fuera_de_servicio'))
);

CREATE TABLE movimientos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    equipo_id UUID NOT NULL REFERENCES equipos(id),
    obra_origen_id UUID REFERENCES obras(id),
    obra_destino_id UUID REFERENCES obras(id),
    fecha DATE NOT NULL
);

CREATE TABLE cargas_masivas (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    usuario_id UUID NOT NULL REFERENCES usuarios(id),
    fecha DATE NOT NULL,
    archivo VARCHAR(255)
);

CREATE TABLE mediciones (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    equipo_id UUID NOT NULL REFERENCES equipos(id),
    fecha DATE NOT NULL,
    valor NUMERIC(12,2) NOT NULL,
    origen VARCHAR(20) NOT NULL CHECK (origen IN ('individual', 'carga_masiva')),
    usuario_id UUID REFERENCES usuarios(id),
    carga_masiva_id UUID REFERENCES cargas_masivas(id)
);

CREATE TABLE mantenimientos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    equipo_id UUID NOT NULL REFERENCES equipos(id),
    fecha DATE NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    costo NUMERIC(12,2)
);

CREATE TABLE estados_historial (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    equipo_id UUID NOT NULL REFERENCES equipos(id),
    estado VARCHAR(20) NOT NULL,
    fecha_desde DATE NOT NULL,
    fecha_hasta DATE
);

-- Registra cada cambio de medidor físico, para poder reconstruir
-- el horómetro/km acumulado real del equipo sin perder el historial
CREATE TABLE cambios_medidor (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    equipo_id UUID NOT NULL REFERENCES equipos(id),
    fecha DATE NOT NULL,
    lectura_anterior NUMERIC(12,2) NOT NULL,
    lectura_nueva NUMERIC(12,2) NOT NULL
);
