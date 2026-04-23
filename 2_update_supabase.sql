-- Agregar mecánico Ynurrigarro
insert into operadores (nombre, apellidos, pin, rol) values
  ('Taller', 'Ynurrigarro', '2024', 'mecanico')
on conflict do nothing;

-- Tabla de trabajos realizados por mecánico
create table if not exists trabajos_mecanico (
  id uuid primary key default gen_random_uuid(),
  unidad_id uuid references unidades(id),
  reparacion_id uuid references reparaciones(id),
  mecanico_id uuid references operadores(id),
  fecha date not null,
  descripcion text not null,
  tipo text default 'correctivo',
  partes_usadas text[],
  costo_mano_obra numeric default 0,
  costo_partes numeric default 0,
  costo_total numeric default 0,
  km_en_servicio integer,
  observaciones text,
  created_at timestamptz default now()
);

alter table trabajos_mecanico enable row level security;
create policy "acceso_total" on trabajos_mecanico for all using (true) with check (true);
