drop policy "Allow moderator access" on "public"."teams";

create policy "Allow moderator access"
on "public"."teams"
as permissive
for select
to authenticated
using ((EXISTS ( SELECT 1
   FROM auth.users
  WHERE ((users.id = auth.uid()) AND ((users.role)::text = ANY ((ARRAY['admin'::character varying, 'moderator'::character varying])::text[]))))));



