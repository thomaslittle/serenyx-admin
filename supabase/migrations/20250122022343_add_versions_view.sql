-- Create view for versions with user information
create or replace view public.versions_with_users as
select 
    v.id,
    v.created_at,
    v.document_type,
    v.content,
    v.created_by,
    v.version_number,
    v.is_current,
    u.email as user_email
from public.versions v
left join auth.users u on u.id = v.created_by;

-- Grant necessary permissions
grant select on public.versions_with_users to authenticated;
