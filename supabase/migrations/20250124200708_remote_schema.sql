

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE TYPE "public"."user_role" AS ENUM (
    'admin',
    'moderator',
    'user'
);


ALTER TYPE "public"."user_role" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."add_role_to_jwt"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  NEW.claims = jsonb_set(
    NEW.claims,
    '{role}',
    to_jsonb((SELECT role FROM auth.users WHERE id = NEW.user_id))
  );
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."add_role_to_jwt"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_user_role"() RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
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
$$;


ALTER FUNCTION "public"."get_user_role"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_user_role"("user_id" "uuid") RETURNS "text"
    LANGUAGE "sql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
    SELECT role::text
    FROM auth.users
    WHERE id = user_id
    AND user_id = auth.uid();
$$;


ALTER FUNCTION "public"."get_user_role"("user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."rollback_document_version"("p_document_type" "text", "p_version_id" "uuid") RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
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


ALTER FUNCTION "public"."rollback_document_version"("p_document_type" "text", "p_version_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."save_document_version"("p_document_type" "text", "p_content" "text", "p_created_by" "uuid", "p_version_number" integer) RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
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


ALTER FUNCTION "public"."save_document_version"("p_document_type" "text", "p_content" "text", "p_created_by" "uuid", "p_version_number" integer) OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."matches" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "team1_id" "uuid" NOT NULL,
    "team2_id" "uuid" NOT NULL,
    "team1_score" integer DEFAULT 0,
    "team2_score" integer DEFAULT 0,
    "status" "text" DEFAULT 'upcoming'::"text",
    "tournament_id" "uuid",
    "division" "text" NOT NULL,
    "start_time" timestamp with time zone NOT NULL,
    CONSTRAINT "matches_status_check" CHECK (("status" = ANY (ARRAY['upcoming'::"text", 'live'::"text", 'completed'::"text"]))),
    CONSTRAINT "matches_teams_different" CHECK (("team1_id" <> "team2_id"))
);


ALTER TABLE "public"."matches" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."teams" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "name" "text" NOT NULL,
    "division" "text" NOT NULL,
    "wins" integer DEFAULT 0,
    "losses" integer DEFAULT 0,
    "points" integer DEFAULT 0,
    "logo_url" "text"
);


ALTER TABLE "public"."teams" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."players" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "name" "text" NOT NULL,
    "team_id" "uuid" NOT NULL,
    "stats" "jsonb" DEFAULT '{"goals": 0, "saves": 0, "shots": 0, "assists": 0}'::"jsonb"
);


ALTER TABLE "public"."players" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."tournaments" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "name" "text" NOT NULL,
    "start_date" timestamp with time zone NOT NULL,
    "end_date" timestamp with time zone NOT NULL,
    "status" "text" DEFAULT 'upcoming'::"text",
    "prize_pool" numeric(10,2),
    "format" "text" NOT NULL,
    CONSTRAINT "tournaments_status_check" CHECK (("status" = ANY (ARRAY['upcoming'::"text", 'active'::"text", 'completed'::"text"])))
);


ALTER TABLE "public"."tournaments" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."versions" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "document_type" "text" NOT NULL,
    "content" "text" NOT NULL,
    "created_by" "uuid" NOT NULL,
    "version_number" integer NOT NULL,
    "is_current" boolean DEFAULT false NOT NULL,
    CONSTRAINT "versions_document_type_check" CHECK (("document_type" = ANY (ARRAY['changelog'::"text", 'broadcast_script'::"text"])))
);


ALTER TABLE "public"."versions" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."versions_with_users" AS
 SELECT "v"."id",
    "v"."created_at",
    "v"."document_type",
    "v"."content",
    "v"."created_by",
    "v"."version_number",
    "v"."is_current",
    "u"."email" AS "user_email"
   FROM ("public"."versions" "v"
     LEFT JOIN "auth"."users" "u" ON (("u"."id" = "v"."created_by")));


ALTER TABLE "public"."versions_with_users" OWNER TO "postgres";


ALTER TABLE ONLY "public"."matches"
    ADD CONSTRAINT "matches_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."players"
    ADD CONSTRAINT "players_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."teams"
    ADD CONSTRAINT "teams_name_unique" UNIQUE ("name");



ALTER TABLE ONLY "public"."teams"
    ADD CONSTRAINT "teams_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tournaments"
    ADD CONSTRAINT "tournaments_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."versions"
    ADD CONSTRAINT "versions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."versions"
    ADD CONSTRAINT "fk_created_by" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."matches"
    ADD CONSTRAINT "matches_team1_id_fkey" FOREIGN KEY ("team1_id") REFERENCES "public"."teams"("id");



ALTER TABLE ONLY "public"."matches"
    ADD CONSTRAINT "matches_team2_id_fkey" FOREIGN KEY ("team2_id") REFERENCES "public"."teams"("id");



ALTER TABLE ONLY "public"."players"
    ADD CONSTRAINT "players_team_id_fkey" FOREIGN KEY ("team_id") REFERENCES "public"."teams"("id");



CREATE POLICY "Admin full access" ON "public"."matches" TO "authenticated" USING (("auth"."role"() = 'admin'::"text")) WITH CHECK (("auth"."role"() = 'admin'::"text"));



CREATE POLICY "Admin full access" ON "public"."players" TO "authenticated" USING (("auth"."role"() = 'admin'::"text")) WITH CHECK (("auth"."role"() = 'admin'::"text"));



CREATE POLICY "Admin full access" ON "public"."teams" TO "authenticated" USING (("auth"."role"() = 'admin'::"text")) WITH CHECK (("auth"."role"() = 'admin'::"text"));



CREATE POLICY "Admin full access" ON "public"."tournaments" TO "authenticated" USING (("auth"."role"() = 'admin'::"text")) WITH CHECK (("auth"."role"() = 'admin'::"text"));



CREATE POLICY "Admin full access" ON "public"."versions" TO "authenticated" USING (("auth"."role"() = 'admin'::"text")) WITH CHECK (("auth"."role"() = 'admin'::"text"));



CREATE POLICY "Admins have full access to versions" ON "public"."versions" TO "authenticated" USING ((("auth"."jwt"() ->> 'role'::"text") = 'admin'::"text")) WITH CHECK ((("auth"."jwt"() ->> 'role'::"text") = 'admin'::"text"));



CREATE POLICY "Allow admin access" ON "public"."teams" TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "auth"."users"
  WHERE (("users"."id" = "auth"."uid"()) AND (("users"."role")::"text" = 'admin'::"text")))));



CREATE POLICY "Allow moderator access" ON "public"."teams" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "auth"."users"
  WHERE (("users"."id" = "auth"."uid"()) AND (("users"."role")::"text" = ANY ((ARRAY['admin'::character varying, 'moderator'::character varying])::"text"[]))))));



CREATE POLICY "Moderator read access" ON "public"."matches" FOR SELECT TO "authenticated" USING (("auth"."role"() = ANY (ARRAY['admin'::"text", 'moderator'::"text"])));



CREATE POLICY "Moderators can create versions" ON "public"."versions" FOR INSERT TO "authenticated" WITH CHECK ((("auth"."jwt"() ->> 'role'::"text") = ANY (ARRAY['admin'::"text", 'moderator'::"text"])));



CREATE POLICY "Moderators can update matches" ON "public"."matches" FOR UPDATE TO "authenticated" USING ((("auth"."jwt"() ->> 'role'::"text") = ANY (ARRAY['admin'::"text", 'moderator'::"text"]))) WITH CHECK ((("auth"."jwt"() ->> 'role'::"text") = ANY (ARRAY['admin'::"text", 'moderator'::"text"])));



CREATE POLICY "Moderators can view and create versions" ON "public"."versions" FOR SELECT TO "authenticated" USING ((("auth"."jwt"() ->> 'role'::"text") = ANY (ARRAY['admin'::"text", 'moderator'::"text"])));



CREATE POLICY "Moderators can view matches" ON "public"."matches" FOR SELECT TO "authenticated" USING ((("auth"."jwt"() ->> 'role'::"text") = ANY (ARRAY['admin'::"text", 'moderator'::"text"])));



CREATE POLICY "Players are editable by authenticated users" ON "public"."players" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Players are viewable by everyone" ON "public"."players" FOR SELECT USING (true);



CREATE POLICY "Public can view matches" ON "public"."matches" FOR SELECT USING (true);



CREATE POLICY "Public read access" ON "public"."matches" FOR SELECT USING (true);



CREATE POLICY "Teams are editable by authenticated users" ON "public"."teams" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Teams are viewable by everyone" ON "public"."teams" FOR SELECT USING (true);



CREATE POLICY "Tournaments are editable by authenticated users" ON "public"."tournaments" TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Tournaments are viewable by everyone" ON "public"."tournaments" FOR SELECT USING (true);



CREATE POLICY "Versions are editable by authenticated users" ON "public"."versions" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "Versions are updatable by authenticated users" ON "public"."versions" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Versions are viewable by authenticated users" ON "public"."versions" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "admin_access" ON "public"."teams" TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "auth"."users"
  WHERE (("users"."id" = "auth"."uid"()) AND (("users"."role")::"text" = 'admin'::"text")))));



CREATE POLICY "admin_access_teams" ON "public"."teams" TO "authenticated" USING ((( SELECT ("users"."role")::"text" AS "role"
   FROM "auth"."users"
  WHERE ("users"."id" = "auth"."uid"())) = 'admin'::"text"));



ALTER TABLE "public"."matches" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."players" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."teams" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."tournaments" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."versions" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."matches";



ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."players";



ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."teams";



ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."tournaments";



ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."versions";



GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";




















































































































































































GRANT ALL ON FUNCTION "public"."add_role_to_jwt"() TO "anon";
GRANT ALL ON FUNCTION "public"."add_role_to_jwt"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."add_role_to_jwt"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_user_role"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_user_role"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_user_role"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_user_role"("user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_user_role"("user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_user_role"("user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."rollback_document_version"("p_document_type" "text", "p_version_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."rollback_document_version"("p_document_type" "text", "p_version_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."rollback_document_version"("p_document_type" "text", "p_version_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."save_document_version"("p_document_type" "text", "p_content" "text", "p_created_by" "uuid", "p_version_number" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."save_document_version"("p_document_type" "text", "p_content" "text", "p_created_by" "uuid", "p_version_number" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."save_document_version"("p_document_type" "text", "p_content" "text", "p_created_by" "uuid", "p_version_number" integer) TO "service_role";



GRANT ALL ON TABLE "public"."matches" TO "anon";
GRANT ALL ON TABLE "public"."matches" TO "authenticated";
GRANT ALL ON TABLE "public"."matches" TO "service_role";



GRANT ALL ON TABLE "public"."teams" TO "anon";
GRANT ALL ON TABLE "public"."teams" TO "authenticated";
GRANT ALL ON TABLE "public"."teams" TO "service_role";


















GRANT ALL ON TABLE "public"."players" TO "anon";
GRANT ALL ON TABLE "public"."players" TO "authenticated";
GRANT ALL ON TABLE "public"."players" TO "service_role";



GRANT ALL ON TABLE "public"."tournaments" TO "anon";
GRANT ALL ON TABLE "public"."tournaments" TO "authenticated";
GRANT ALL ON TABLE "public"."tournaments" TO "service_role";



GRANT ALL ON TABLE "public"."versions" TO "anon";
GRANT ALL ON TABLE "public"."versions" TO "authenticated";
GRANT ALL ON TABLE "public"."versions" TO "service_role";



GRANT ALL ON TABLE "public"."versions_with_users" TO "anon";
GRANT ALL ON TABLE "public"."versions_with_users" TO "authenticated";
GRANT ALL ON TABLE "public"."versions_with_users" TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";






























RESET ALL;
