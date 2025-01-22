alter table "public"."versions" drop constraint "fk_created_by";

alter table "public"."versions" add constraint "versions_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."versions" validate constraint "versions_created_by_fkey";


