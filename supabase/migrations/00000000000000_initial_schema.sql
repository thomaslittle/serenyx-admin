-- Enable necessary extensions
create extension if not exists "uuid-ossp";

-- Create teams table
create table public.teams (
    id uuid primary key default uuid_generate_v4(),
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    name text not null,
    division text not null,
    wins integer default 0,
    losses integer default 0,
    points integer default 0,
    logo_url text,
    
    constraint teams_name_unique unique (name)
);

-- Create matches table
create table public.matches (
    id uuid primary key default uuid_generate_v4(),
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    team1_id uuid references public.teams(id) not null,
    team2_id uuid references public.teams(id) not null,
    team1_score integer default 0,
    team2_score integer default 0,
    status text check (status in ('upcoming', 'live', 'completed')) default 'upcoming',
    tournament_id uuid,
    division text not null,
    start_time timestamp with time zone not null,
    
    constraint matches_teams_different check (team1_id != team2_id)
);

-- Create players table
create table public.players (
    id uuid primary key default uuid_generate_v4(),
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    name text not null,
    team_id uuid references public.teams(id) not null,
    stats jsonb default '{
        "goals": 0,
        "assists": 0,
        "saves": 0,
        "shots": 0
    }'::jsonb
);

-- Create tournaments table
create table public.tournaments (
    id uuid primary key default uuid_generate_v4(),
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    name text not null,
    start_date timestamp with time zone not null,
    end_date timestamp with time zone not null,
    status text check (status in ('upcoming', 'active', 'completed')) default 'upcoming',
    prize_pool numeric(10,2),
    format text not null
);

-- Enable Row Level Security (RLS)
alter table public.teams enable row level security;
alter table public.matches enable row level security;
alter table public.players enable row level security;
alter table public.tournaments enable row level security;

-- Create policies
-- Teams: Anyone can read, only authenticated users can modify
create policy "Teams are viewable by everyone"
    on public.teams for select
    to public
    using (true);

create policy "Teams are editable by authenticated users"
    on public.teams for all
    to authenticated
    using (true)
    with check (true);

-- Matches: Same as teams
create policy "Matches are viewable by everyone"
    on public.matches for select
    to public
    using (true);

create policy "Matches are editable by authenticated users"
    on public.matches for all
    to authenticated
    using (true)
    with check (true);

-- Players: Same as above
create policy "Players are viewable by everyone"
    on public.players for select
    to public
    using (true);

create policy "Players are editable by authenticated users"
    on public.players for all
    to authenticated
    using (true)
    with check (true);

-- Tournaments: Same as above
create policy "Tournaments are viewable by everyone"
    on public.tournaments for select
    to public
    using (true);

create policy "Tournaments are editable by authenticated users"
    on public.tournaments for all
    to authenticated
    using (true)
    with check (true);