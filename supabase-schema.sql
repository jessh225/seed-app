-- =============================================
-- Seed App Database Schema
-- Run this in Supabase SQL Editor
-- =============================================

-- Step 1: Add user_id columns to existing tables (run if tables exist)
-- Or create fresh tables with user_id

-- Ideas table
create table if not exists ideas (
  id bigint primary key generated always as identity,
  user_id uuid references auth.users on delete cascade,
  text text not null,
  notes text default '',
  date date,
  created_at timestamp with time zone default now()
);

-- Projects table
create table if not exists projects (
  id bigint primary key generated always as identity,
  user_id uuid references auth.users on delete cascade,
  name text not null,
  color text not null,
  created_at timestamp with time zone default now()
);

-- Project items table
create table if not exists project_items (
  id bigint primary key generated always as identity,
  project_id bigint references projects on delete cascade,
  user_id uuid references auth.users on delete cascade,
  text text not null,
  notes text default '',
  date date,
  done boolean default false,
  created_at timestamp with time zone default now()
);

-- =============================================
-- If tables already exist, run these ALTER statements:
-- =============================================
-- ALTER TABLE ideas ADD COLUMN IF NOT EXISTS user_id uuid references auth.users on delete cascade;
-- ALTER TABLE projects ADD COLUMN IF NOT EXISTS user_id uuid references auth.users on delete cascade;
-- ALTER TABLE project_items ADD COLUMN IF NOT EXISTS user_id uuid references auth.users on delete cascade;

-- =============================================
-- Row Level Security (RLS) - REQUIRED for multi-user
-- =============================================

-- Enable RLS
alter table ideas enable row level security;
alter table projects enable row level security;
alter table project_items enable row level security;

-- Drop existing policies if any
drop policy if exists "Users can view own ideas" on ideas;
drop policy if exists "Users can insert own ideas" on ideas;
drop policy if exists "Users can update own ideas" on ideas;
drop policy if exists "Users can delete own ideas" on ideas;

drop policy if exists "Users can view own projects" on projects;
drop policy if exists "Users can insert own projects" on projects;
drop policy if exists "Users can update own projects" on projects;
drop policy if exists "Users can delete own projects" on projects;

drop policy if exists "Users can view own project_items" on project_items;
drop policy if exists "Users can insert own project_items" on project_items;
drop policy if exists "Users can update own project_items" on project_items;
drop policy if exists "Users can delete own project_items" on project_items;

-- Ideas policies
create policy "Users can view own ideas" on ideas
  for select using (auth.uid() = user_id);

create policy "Users can insert own ideas" on ideas
  for insert with check (auth.uid() = user_id);

create policy "Users can update own ideas" on ideas
  for update using (auth.uid() = user_id);

create policy "Users can delete own ideas" on ideas
  for delete using (auth.uid() = user_id);

-- Projects policies
create policy "Users can view own projects" on projects
  for select using (auth.uid() = user_id);

create policy "Users can insert own projects" on projects
  for insert with check (auth.uid() = user_id);

create policy "Users can update own projects" on projects
  for update using (auth.uid() = user_id);

create policy "Users can delete own projects" on projects
  for delete using (auth.uid() = user_id);

-- Project items policies
create policy "Users can view own project_items" on project_items
  for select using (auth.uid() = user_id);

create policy "Users can insert own project_items" on project_items
  for insert with check (auth.uid() = user_id);

create policy "Users can update own project_items" on project_items
  for update using (auth.uid() = user_id);

create policy "Users can delete own project_items" on project_items
  for delete using (auth.uid() = user_id);

-- =============================================
-- Index for performance
-- =============================================
create index if not exists ideas_user_id_idx on ideas(user_id);
create index if not exists projects_user_id_idx on projects(user_id);
create index if not exists project_items_user_id_idx on project_items(user_id);
create index if not exists project_items_project_id_idx on project_items(project_id);
