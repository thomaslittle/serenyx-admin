-- Create versions table
create table public.versions (
    id uuid primary key default uuid_generate_v4(),
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    document_type text check (document_type in ('changelog', 'broadcast_script')) not null,
    content text not null,
    created_by uuid not null,
    version_number integer not null,
    is_current boolean default false not null,
    constraint fk_created_by foreign key (created_by) references auth.users(id)
);

-- Enable RLS
alter table public.versions enable row level security;

-- Create policies
create policy "Versions are viewable by authenticated users"
    on public.versions for select
    to authenticated
    using (true);

create policy "Versions are editable by authenticated users"
    on public.versions for insert
    to authenticated
    with check (true);

create policy "Versions are updatable by authenticated users"
    on public.versions for update
    to authenticated
    using (true)
    with check (true);

-- Create function to save document version
create or replace function public.save_document_version(
    p_document_type text,
    p_content text,
    p_created_by uuid,
    p_version_number integer
) returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
    v_result jsonb;
begin
    -- Set all current versions of this document type to false
    update public.versions
    set is_current = false
    where document_type = p_document_type;

    -- Insert new version
    insert into public.versions (
        document_type,
        content,
        created_by,
        version_number,
        is_current
    ) values (
        p_document_type,
        p_content,
        p_created_by,
        p_version_number,
        true
    )
    returning jsonb_build_object(
        'id', id,
        'version_number', version_number
    ) into v_result;

    return v_result;
end;
$$;

-- Create function to rollback document version
create or replace function public.rollback_document_version(
    p_document_type text,
    p_version_id uuid
) returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
    v_result jsonb;
begin
    -- Set all current versions of this document type to false
    update public.versions
    set is_current = false
    where document_type = p_document_type;

    -- Set the specified version to current
    update public.versions
    set is_current = true
    where id = p_version_id
    returning jsonb_build_object(
        'id', id,
        'version_number', version_number
    ) into v_result;

    return v_result;
end;
$$;

-- Grant necessary permissions
grant usage on schema public to authenticated;
grant all on public.versions to authenticated;
grant execute on function public.save_document_version to authenticated;
grant execute on function public.rollback_document_version to authenticated; 