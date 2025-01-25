drop policy "Allow moderator access" on "public"."teams";

drop policy "admin_access" on "public"."teams";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.add_role_to_jwt()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  NEW.claims = jsonb_set(
    NEW.claims,
    '{role}',
    to_jsonb((SELECT role FROM auth.users WHERE id = NEW.user_id))
  );
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_user_role()
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
  user_role TEXT;
BEGIN
  -- Get the role from the auth.users table
  SELECT role INTO user_role
  FROM auth.users
  WHERE id = auth.uid();
  
  -- Return the role as a JSONB object
  RETURN jsonb_build_object('role', user_role);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_user_role(user_id uuid)
 RETURNS text
 LANGUAGE sql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
    SELECT role::text
    FROM auth.users
    WHERE id = user_id
    AND user_id = auth.uid();
$function$
;

create policy "Allow moderator access"
on "public"."teams"
as permissive
for select
to authenticated
using ((EXISTS ( SELECT 1
   FROM auth.users
  WHERE ((users.id = auth.uid()) AND ((users.role)::text = ANY ((ARRAY['admin'::character varying, 'moderator'::character varying])::text[]))))));


create policy "admin_access"
on "public"."teams"
as permissive
for all
to authenticated
using (((auth.jwt() ->> 'role'::text) = 'admin'::text));



