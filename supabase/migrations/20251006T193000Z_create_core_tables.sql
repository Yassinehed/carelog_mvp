-- Migration: create_core_tables
-- Date: 2025-10-06T19:30:00Z

-- Create manufacturing_orders table
create table if not exists public.manufacturing_orders (
  id uuid primary key default gen_random_uuid(),
  client text not null,
  product text not null,
  quantity integer not null,
  description text,
  status text not null default 'draft',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid -- user id (foreign key to auth.users)
);

-- Create signalements table
create table if not exists public.signalements (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  severity text not null default 'low',
  metadata jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid
);

-- Create materials table
create table if not exists public.materials (
  id uuid primary key default gen_random_uuid(),
  sku text not null unique,
  name text not null,
  quantity_on_hand integer not null default 0,
  unit text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid
);

-- Enable Row Level Security and example policies
alter table public.manufacturing_orders enable row level security;
create policy "Allow authenticated select on manufacturing_orders" on public.manufacturing_orders
  for select using (auth.uid() IS NOT NULL);
create policy "Allow owner insert/update/delete on manufacturing_orders" on public.manufacturing_orders
  for all using (auth.uid() = created_by) with check (auth.uid() = created_by);

alter table public.signalements enable row level security;
create policy "Allow authenticated select on signalements" on public.signalements
  for select using (auth.uid() IS NOT NULL);
create policy "Allow owner insert/update/delete on signalements" on public.signalements
  for all using (auth.uid() = created_by) with check (auth.uid() = created_by);

alter table public.materials enable row level security;
create policy "Allow authenticated select on materials" on public.materials
  for select using (auth.uid() IS NOT NULL);
create policy "Allow owner insert/update/delete on materials" on public.materials
  for all using (auth.uid() = created_by) with check (auth.uid() = created_by);

-- Indexes for common queries
create index if not exists idx_manufacturing_orders_created_at on public.manufacturing_orders(created_at);
create index if not exists idx_signalements_severity on public.signalements(severity);
create index if not exists idx_materials_sku on public.materials(sku);
