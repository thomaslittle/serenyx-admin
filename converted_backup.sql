--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 17.2 (Ubuntu 17.2-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA "auth";


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "extensions";


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA "graphql";


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA "graphql_public";


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA "pgbouncer";


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: pgsodium; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA "pgsodium";


ALTER SCHEMA pgsodium OWNER TO supabase_admin;

--
-- Name: pgsodium; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";


--
-- Name: EXTENSION "pgsodium"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "pgsodium" IS 'Pgsodium is a modern cryptography library for Postgres.';


--
-- Name: SCHEMA "public"; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA "public" IS 'standard public schema';


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA "realtime";


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA "storage";


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "supabase_migrations";


ALTER SCHEMA supabase_migrations OWNER TO postgres;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA "vault";


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";


--
-- Name: EXTENSION "pg_graphql"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "pg_graphql" IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";


--
-- Name: EXTENSION "pg_stat_statements"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "pg_stat_statements" IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";


--
-- Name: EXTENSION "pgcrypto"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "pgcrypto" IS 'cryptographic functions';


--
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";


--
-- Name: EXTENSION "pgjwt"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "pgjwt" IS 'JSON Web Token API for Postgresql';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";


--
-- Name: EXTENSION "supabase_vault"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "supabase_vault" IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE "auth"."aal_level" AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE "auth"."code_challenge_method" AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE "auth"."factor_status" AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE "auth"."factor_type" AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE "auth"."one_time_token_type" AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE "public"."user_role" AS ENUM (
    'admin',
    'moderator',
    'user'
);


ALTER TYPE public.user_role OWNER TO postgres;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE "realtime"."action" AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE "realtime"."equality_op" AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE "realtime"."user_defined_filter" AS (
	"column_name" "text",
	"op" "realtime"."equality_op",
	"value" "text"
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE "realtime"."wal_column" AS (
	"name" "text",
	"type_name" "text",
	"type_oid" "oid",
	"value" "jsonb",
	"is_pkey" boolean,
	"is_selectable" boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE "realtime"."wal_rls" AS (
	"wal" "jsonb",
	"is_rls_enabled" boolean,
	"subscription_ids" "uuid"[],
	"errors" "text"[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: check_user_role("text"); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION "auth"."check_user_role"("required_role" "text") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1 FROM auth.users
        WHERE id = auth.uid()
        AND role::text = required_role
    );
END;
$$;


ALTER FUNCTION "auth"."check_user_role"("required_role" "text") OWNER TO postgres;

--
-- Name: check_user_role_in("text"[]); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION "auth"."check_user_role_in"("required_roles" "text"[]) RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1 FROM auth.users
        WHERE id = auth.uid()
        AND role::text = ANY(required_roles)
    );
END;
$$;


ALTER FUNCTION "auth"."check_user_role_in"("required_roles" "text"[]) OWNER TO postgres;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION "auth"."email"() RETURNS "text"
    LANGUAGE "sql" STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION "auth"."email"() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION "email"(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION "auth"."email"() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: is_admin(); Type: FUNCTION; Schema: auth; Owner: postgres
--

CREATE FUNCTION "auth"."is_admin"() RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  RETURN (SELECT role = 'admin' FROM auth.users WHERE id = auth.uid());
END;
$$;


ALTER FUNCTION "auth"."is_admin"() OWNER TO postgres;

--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION "auth"."jwt"() RETURNS "jsonb"
    LANGUAGE "sql" STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION "auth"."jwt"() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION "auth"."role"() RETURNS "text"
    LANGUAGE "sql" STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION "auth"."role"() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION "role"(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION "auth"."role"() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION "auth"."uid"() RETURNS "uuid"
    LANGUAGE "sql" STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION "auth"."uid"() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION "uid"(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION "auth"."uid"() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION "extensions"."grant_pg_cron_access"() RETURNS "event_trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION "extensions"."grant_pg_cron_access"() OWNER TO postgres;

--
-- Name: FUNCTION "grant_pg_cron_access"(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION "extensions"."grant_pg_cron_access"() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION "extensions"."grant_pg_graphql_access"() RETURNS "event_trigger"
    LANGUAGE "plpgsql"
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION "extensions"."grant_pg_graphql_access"() OWNER TO supabase_admin;

--
-- Name: FUNCTION "grant_pg_graphql_access"(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION "extensions"."grant_pg_graphql_access"() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION "extensions"."grant_pg_net_access"() RETURNS "event_trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

    REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
    REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

    GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
  END IF;
END;
$$;


ALTER FUNCTION "extensions"."grant_pg_net_access"() OWNER TO postgres;

--
-- Name: FUNCTION "grant_pg_net_access"(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION "extensions"."grant_pg_net_access"() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION "extensions"."pgrst_ddl_watch"() RETURNS "event_trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION "extensions"."pgrst_ddl_watch"() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION "extensions"."pgrst_drop_watch"() RETURNS "event_trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION "extensions"."pgrst_drop_watch"() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION "extensions"."set_graphql_placeholder"() RETURNS "event_trigger"
    LANGUAGE "plpgsql"
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION "extensions"."set_graphql_placeholder"() OWNER TO supabase_admin;

--
-- Name: FUNCTION "set_graphql_placeholder"(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION "extensions"."set_graphql_placeholder"() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth("text"); Type: FUNCTION; Schema: pgbouncer; Owner: postgres
--

CREATE FUNCTION "pgbouncer"."get_auth"("p_usename" "text") RETURNS TABLE("username" "text", "password" "text")
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    RAISE WARNING 'PgBouncer auth request: %', p_usename;

    RETURN QUERY
    SELECT usename::TEXT, passwd::TEXT FROM pg_catalog.pg_shadow
    WHERE usename = p_usename;
END;
$$;


ALTER FUNCTION "pgbouncer"."get_auth"("p_usename" "text") OWNER TO postgres;

--
-- Name: add_role_to_jwt(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."add_role_to_jwt"() RETURNS "trigger"
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


ALTER FUNCTION "public"."add_role_to_jwt"() OWNER TO postgres;

--
-- Name: get_user_role(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."get_user_role"() RETURNS "jsonb"
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


ALTER FUNCTION "public"."get_user_role"() OWNER TO postgres;

--
-- Name: get_user_role("uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."get_user_role"("user_id" "uuid") RETURNS "text"
    LANGUAGE "sql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
    SELECT role::text
    FROM auth.users
    WHERE id = user_id
    AND user_id = auth.uid();
$$;


ALTER FUNCTION "public"."get_user_role"("user_id" "uuid") OWNER TO postgres;

--
-- Name: rollback_document_version("text", "uuid"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."rollback_document_version"("p_document_type" "text", "p_version_id" "uuid") RETURNS "jsonb"
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


ALTER FUNCTION "public"."rollback_document_version"("p_document_type" "text", "p_version_id" "uuid") OWNER TO postgres;

--
-- Name: save_document_version("text", "text", "uuid", integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "public"."save_document_version"("p_document_type" "text", "p_content" "text", "p_created_by" "uuid", "p_version_number" integer) RETURNS "jsonb"
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


ALTER FUNCTION "public"."save_document_version"("p_document_type" "text", "p_content" "text", "p_created_by" "uuid", "p_version_number" integer) OWNER TO postgres;

--
-- Name: apply_rls("jsonb", integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION "realtime"."apply_rls"("wal" "jsonb", "max_record_bytes" integer DEFAULT (1024 * 1024)) RETURNS SETOF "realtime"."wal_rls"
    LANGUAGE "plpgsql"
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION "realtime"."apply_rls"("wal" "jsonb", "max_record_bytes" integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes("text", "text", "text", "text", "text", "record", "record", "text"); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION "realtime"."broadcast_changes"("topic_name" "text", "event_name" "text", "operation" "text", "table_name" "text", "table_schema" "text", "new" "record", "old" "record", "level" "text" DEFAULT 'ROW'::"text") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION "realtime"."broadcast_changes"("topic_name" "text", "event_name" "text", "operation" "text", "table_name" "text", "table_schema" "text", "new" "record", "old" "record", "level" "text") OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql("text", "regclass", "realtime"."wal_column"[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION "realtime"."build_prepared_statement_sql"("prepared_statement_name" "text", "entity" "regclass", "columns" "realtime"."wal_column"[]) RETURNS "text"
    LANGUAGE "sql"
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION "realtime"."build_prepared_statement_sql"("prepared_statement_name" "text", "entity" "regclass", "columns" "realtime"."wal_column"[]) OWNER TO supabase_admin;

--
-- Name: cast("text", "regtype"); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION "realtime"."cast"("val" "text", "type_" "regtype") RETURNS "jsonb"
    LANGUAGE "plpgsql" IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION "realtime"."cast"("val" "text", "type_" "regtype") OWNER TO supabase_admin;

--
-- Name: check_equality_op("realtime"."equality_op", "regtype", "text", "text"); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION "realtime"."check_equality_op"("op" "realtime"."equality_op", "type_" "regtype", "val_1" "text", "val_2" "text") RETURNS boolean
    LANGUAGE "plpgsql" IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION "realtime"."check_equality_op"("op" "realtime"."equality_op", "type_" "regtype", "val_1" "text", "val_2" "text") OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters("realtime"."wal_column"[], "realtime"."user_defined_filter"[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION "realtime"."is_visible_through_filters"("columns" "realtime"."wal_column"[], "filters" "realtime"."user_defined_filter"[]) RETURNS boolean
    LANGUAGE "sql" IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION "realtime"."is_visible_through_filters"("columns" "realtime"."wal_column"[], "filters" "realtime"."user_defined_filter"[]) OWNER TO supabase_admin;

--
-- Name: list_changes("name", "name", integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION "realtime"."list_changes"("publication" "name", "slot_name" "name", "max_changes" integer, "max_record_bytes" integer) RETURNS SETOF "realtime"."wal_rls"
    LANGUAGE "sql"
    SET "log_min_messages" TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION "realtime"."list_changes"("publication" "name", "slot_name" "name", "max_changes" integer, "max_record_bytes" integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json("regclass"); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION "realtime"."quote_wal2json"("entity" "regclass") RETURNS "text"
    LANGUAGE "sql" IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION "realtime"."quote_wal2json"("entity" "regclass") OWNER TO supabase_admin;

--
-- Name: send("jsonb", "text", "text", boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION "realtime"."send"("payload" "jsonb", "event" "text", "topic" "text", "private" boolean DEFAULT true) RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    SET LOCAL realtime.topic TO topic;

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      PERFORM pg_notify(
          'realtime:system',
          jsonb_build_object(
              'error', SQLERRM,
              'function', 'realtime.send',
              'event', event,
              'topic', topic,
              'private', private
          )::text
      );
  END;
END;
$$;


ALTER FUNCTION "realtime"."send"("payload" "jsonb", "event" "text", "topic" "text", "private" boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION "realtime"."subscription_check_filters"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION "realtime"."subscription_check_filters"() OWNER TO supabase_admin;

--
-- Name: to_regrole("text"); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION "realtime"."to_regrole"("role_name" "text") RETURNS "regrole"
    LANGUAGE "sql" IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION "realtime"."to_regrole"("role_name" "text") OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION "realtime"."topic"() RETURNS "text"
    LANGUAGE "sql" STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION "realtime"."topic"() OWNER TO supabase_realtime_admin;

--
-- Name: can_insert_object("text", "text", "uuid", "jsonb"); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION "storage"."can_insert_object"("bucketid" "text", "name" "text", "owner" "uuid", "metadata" "jsonb") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION "storage"."can_insert_object"("bucketid" "text", "name" "text", "owner" "uuid", "metadata" "jsonb") OWNER TO supabase_storage_admin;

--
-- Name: extension("text"); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION "storage"."extension"("name" "text") RETURNS "text"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION "storage"."extension"("name" "text") OWNER TO supabase_storage_admin;

--
-- Name: filename("text"); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION "storage"."filename"("name" "text") RETURNS "text"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION "storage"."filename"("name" "text") OWNER TO supabase_storage_admin;

--
-- Name: foldername("text"); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION "storage"."foldername"("name" "text") RETURNS "text"[]
    LANGUAGE "plpgsql"
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION "storage"."foldername"("name" "text") OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION "storage"."get_size_by_bucket"() RETURNS TABLE("size" bigint, "bucket_id" "text")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION "storage"."get_size_by_bucket"() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter("text", "text", "text", integer, "text", "text"); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION "storage"."list_multipart_uploads_with_delimiter"("bucket_id" "text", "prefix_param" "text", "delimiter_param" "text", "max_keys" integer DEFAULT 100, "next_key_token" "text" DEFAULT ''::"text", "next_upload_token" "text" DEFAULT ''::"text") RETURNS TABLE("key" "text", "id" "text", "created_at" timestamp with time zone)
    LANGUAGE "plpgsql"
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION "storage"."list_multipart_uploads_with_delimiter"("bucket_id" "text", "prefix_param" "text", "delimiter_param" "text", "max_keys" integer, "next_key_token" "text", "next_upload_token" "text") OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter("text", "text", "text", integer, "text", "text"); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION "storage"."list_objects_with_delimiter"("bucket_id" "text", "prefix_param" "text", "delimiter_param" "text", "max_keys" integer DEFAULT 100, "start_after" "text" DEFAULT ''::"text", "next_token" "text" DEFAULT ''::"text") RETURNS TABLE("name" "text", "id" "uuid", "metadata" "jsonb", "updated_at" timestamp with time zone)
    LANGUAGE "plpgsql"
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION "storage"."list_objects_with_delimiter"("bucket_id" "text", "prefix_param" "text", "delimiter_param" "text", "max_keys" integer, "start_after" "text", "next_token" "text") OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION "storage"."operation"() RETURNS "text"
    LANGUAGE "plpgsql" STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION "storage"."operation"() OWNER TO supabase_storage_admin;

--
-- Name: search("text", "text", integer, integer, integer, "text", "text", "text"); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION "storage"."search"("prefix" "text", "bucketname" "text", "limits" integer DEFAULT 100, "levels" integer DEFAULT 1, "offsets" integer DEFAULT 0, "search" "text" DEFAULT ''::"text", "sortcolumn" "text" DEFAULT 'name'::"text", "sortorder" "text" DEFAULT 'asc'::"text") RETURNS TABLE("name" "text", "id" "uuid", "updated_at" timestamp with time zone, "created_at" timestamp with time zone, "last_accessed_at" timestamp with time zone, "metadata" "jsonb")
    LANGUAGE "plpgsql" STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION "storage"."search"("prefix" "text", "bucketname" "text", "limits" integer, "levels" integer, "offsets" integer, "search" "text", "sortcolumn" "text", "sortorder" "text") OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION "storage"."update_updated_at_column"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION "storage"."update_updated_at_column"() OWNER TO supabase_storage_admin;

--
-- Name: secrets_encrypt_secret_secret(); Type: FUNCTION; Schema: vault; Owner: supabase_admin
--

CREATE FUNCTION "vault"."secrets_encrypt_secret_secret"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
		BEGIN
		        new.secret = CASE WHEN new.secret IS NULL THEN NULL ELSE
			CASE WHEN new.key_id IS NULL THEN NULL ELSE pg_catalog.encode(
			  pgsodium.crypto_aead_det_encrypt(
				pg_catalog.convert_to(new.secret, 'utf8'),
				pg_catalog.convert_to((new.id::text || new.description::text || new.created_at::text || new.updated_at::text)::text, 'utf8'),
				new.key_id::uuid,
				new.nonce
			  ),
				'base64') END END;
		RETURN new;
		END;
		$$;


ALTER FUNCTION "vault"."secrets_encrypt_secret_secret"() OWNER TO supabase_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."audit_log_entries" (
    "instance_id" "uuid",
    "id" "uuid" NOT NULL,
    "payload" "json",
    "created_at" timestamp with time zone,
    "ip_address" character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE "audit_log_entries"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."audit_log_entries" IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."flow_state" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid",
    "auth_code" "text" NOT NULL,
    "code_challenge_method" "auth"."code_challenge_method" NOT NULL,
    "code_challenge" "text" NOT NULL,
    "provider_type" "text" NOT NULL,
    "provider_access_token" "text",
    "provider_refresh_token" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "authentication_method" "text" NOT NULL,
    "auth_code_issued_at" timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE "flow_state"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."flow_state" IS 'stores metadata for pkce logins';


--
-- Name: hooks; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE "auth"."hooks" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "event" "text" NOT NULL,
    "function_name" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE auth.hooks OWNER TO postgres;

--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."identities" (
    "provider_id" "text" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "identity_data" "jsonb" NOT NULL,
    "provider" "text" NOT NULL,
    "last_sign_in_at" timestamp with time zone,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "email" "text" GENERATED ALWAYS AS ("lower"(("identity_data" ->> 'email'::"text"))) STORED,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE "identities"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."identities" IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN "identities"."email"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN "auth"."identities"."email" IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."instances" (
    "id" "uuid" NOT NULL,
    "uuid" "uuid",
    "raw_base_config" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE "instances"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."instances" IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."mfa_amr_claims" (
    "session_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone NOT NULL,
    "updated_at" timestamp with time zone NOT NULL,
    "authentication_method" "text" NOT NULL,
    "id" "uuid" NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE "mfa_amr_claims"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."mfa_amr_claims" IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."mfa_challenges" (
    "id" "uuid" NOT NULL,
    "factor_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone NOT NULL,
    "verified_at" timestamp with time zone,
    "ip_address" "inet" NOT NULL,
    "otp_code" "text",
    "web_authn_session_data" "jsonb"
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE "mfa_challenges"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."mfa_challenges" IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."mfa_factors" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "friendly_name" "text",
    "factor_type" "auth"."factor_type" NOT NULL,
    "status" "auth"."factor_status" NOT NULL,
    "created_at" timestamp with time zone NOT NULL,
    "updated_at" timestamp with time zone NOT NULL,
    "secret" "text",
    "phone" "text",
    "last_challenged_at" timestamp with time zone,
    "web_authn_credential" "jsonb",
    "web_authn_aaguid" "uuid"
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE "mfa_factors"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."mfa_factors" IS 'auth: stores metadata about factors';


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."one_time_tokens" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "token_type" "auth"."one_time_token_type" NOT NULL,
    "token_hash" "text" NOT NULL,
    "relates_to" "text" NOT NULL,
    "created_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "one_time_tokens_token_hash_check" CHECK (("char_length"("token_hash") > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."refresh_tokens" (
    "instance_id" "uuid",
    "id" bigint NOT NULL,
    "token" character varying(255),
    "user_id" character varying(255),
    "revoked" boolean,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "parent" character varying(255),
    "session_id" "uuid"
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE "refresh_tokens"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."refresh_tokens" IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE "auth"."refresh_tokens_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE "auth"."refresh_tokens_id_seq" OWNED BY "auth"."refresh_tokens"."id";


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."saml_providers" (
    "id" "uuid" NOT NULL,
    "sso_provider_id" "uuid" NOT NULL,
    "entity_id" "text" NOT NULL,
    "metadata_xml" "text" NOT NULL,
    "metadata_url" "text",
    "attribute_mapping" "jsonb",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "name_id_format" "text",
    CONSTRAINT "entity_id not empty" CHECK (("char_length"("entity_id") > 0)),
    CONSTRAINT "metadata_url not empty" CHECK ((("metadata_url" = NULL::"text") OR ("char_length"("metadata_url") > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK (("char_length"("metadata_xml") > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE "saml_providers"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."saml_providers" IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."saml_relay_states" (
    "id" "uuid" NOT NULL,
    "sso_provider_id" "uuid" NOT NULL,
    "request_id" "text" NOT NULL,
    "for_email" "text",
    "redirect_to" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "flow_state_id" "uuid",
    CONSTRAINT "request_id not empty" CHECK (("char_length"("request_id") > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE "saml_relay_states"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."saml_relay_states" IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."schema_migrations" (
    "version" character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE "schema_migrations"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."schema_migrations" IS 'Auth: Manages updates to the auth system.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."users" (
    "instance_id" "uuid",
    "id" "uuid" NOT NULL,
    "aud" character varying(255),
    "role" character varying(255),
    "email" character varying(255),
    "encrypted_password" character varying(255),
    "email_confirmed_at" timestamp with time zone,
    "invited_at" timestamp with time zone,
    "confirmation_token" character varying(255),
    "confirmation_sent_at" timestamp with time zone,
    "recovery_token" character varying(255),
    "recovery_sent_at" timestamp with time zone,
    "email_change_token_new" character varying(255),
    "email_change" character varying(255),
    "email_change_sent_at" timestamp with time zone,
    "last_sign_in_at" timestamp with time zone,
    "raw_app_meta_data" "jsonb",
    "raw_user_meta_data" "jsonb",
    "is_super_admin" boolean,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "phone" "text" DEFAULT NULL::character varying,
    "phone_confirmed_at" timestamp with time zone,
    "phone_change" "text" DEFAULT ''::character varying,
    "phone_change_token" character varying(255) DEFAULT ''::character varying,
    "phone_change_sent_at" timestamp with time zone,
    "confirmed_at" timestamp with time zone GENERATED ALWAYS AS (LEAST("email_confirmed_at", "phone_confirmed_at")) STORED,
    "email_change_token_current" character varying(255) DEFAULT ''::character varying,
    "email_change_confirm_status" smallint DEFAULT 0,
    "banned_until" timestamp with time zone,
    "reauthentication_token" character varying(255) DEFAULT ''::character varying,
    "reauthentication_sent_at" timestamp with time zone,
    "is_sso_user" boolean DEFAULT false NOT NULL,
    "deleted_at" timestamp with time zone,
    "is_anonymous" boolean DEFAULT false NOT NULL,
    "is_admin" boolean DEFAULT false,
    CONSTRAINT "users_email_change_confirm_status_check" CHECK ((("email_change_confirm_status" >= 0) AND ("email_change_confirm_status" <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE "users"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."users" IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN "users"."is_sso_user"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN "auth"."users"."is_sso_user" IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: matches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."matches" (
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


ALTER TABLE public.matches OWNER TO postgres;

--
-- Name: teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."teams" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "name" "text" NOT NULL,
    "division" "text" NOT NULL,
    "wins" integer DEFAULT 0,
    "losses" integer DEFAULT 0,
    "points" integer DEFAULT 0,
    "logo_url" "text"
);


ALTER TABLE public.teams OWNER TO postgres;

--
-- Name: secure_matches; Type: VIEW; Schema: auth; Owner: postgres
--

CREATE VIEW "auth"."secure_matches" AS
 SELECT "m"."id",
    "m"."created_at",
    "m"."team1_id",
    "m"."team2_id",
    "m"."team1_score",
    "m"."team2_score",
    "m"."status",
    "m"."tournament_id",
    "m"."division",
    "m"."start_time",
    "t1"."name" AS "team1_name",
    "t2"."name" AS "team2_name"
   FROM (("public"."matches" "m"
     LEFT JOIN "public"."teams" "t1" ON (("m"."team1_id" = "t1"."id")))
     LEFT JOIN "public"."teams" "t2" ON (("m"."team2_id" = "t2"."id")))
  WHERE (EXISTS ( SELECT 1
           FROM "auth"."users"
          WHERE (("users"."id" = "auth"."uid"()) AND (("users"."role")::"text" = 'admin'::"text"))));


ALTER VIEW auth.secure_matches OWNER TO postgres;

--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."sessions" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "factor_id" "uuid",
    "aal" "auth"."aal_level",
    "not_after" timestamp with time zone,
    "refreshed_at" timestamp without time zone,
    "user_agent" "text",
    "ip" "inet",
    "tag" "text"
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE "sessions"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."sessions" IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN "sessions"."not_after"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN "auth"."sessions"."not_after" IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."sso_domains" (
    "id" "uuid" NOT NULL,
    "sso_provider_id" "uuid" NOT NULL,
    "domain" "text" NOT NULL,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK (("char_length"("domain") > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE "sso_domains"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."sso_domains" IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE "auth"."sso_providers" (
    "id" "uuid" NOT NULL,
    "resource_id" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK ((("resource_id" = NULL::"text") OR ("char_length"("resource_id") > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE "sso_providers"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE "auth"."sso_providers" IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN "sso_providers"."resource_id"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN "auth"."sso_providers"."resource_id" IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: players; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."players" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "name" "text" NOT NULL,
    "team_id" "uuid" NOT NULL,
    "stats" "jsonb" DEFAULT '{"goals": 0, "saves": 0, "shots": 0, "assists": 0}'::"jsonb"
);


ALTER TABLE public.players OWNER TO postgres;

--
-- Name: tournaments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."tournaments" (
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


ALTER TABLE public.tournaments OWNER TO postgres;

--
-- Name: versions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "public"."versions" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "document_type" "text" NOT NULL,
    "content" "text" NOT NULL,
    "created_by" "uuid" NOT NULL,
    "version_number" integer NOT NULL,
    "is_current" boolean DEFAULT false NOT NULL,
    CONSTRAINT "versions_document_type_check" CHECK (("document_type" = ANY (ARRAY['changelog'::"text", 'broadcast_script'::"text"])))
);


ALTER TABLE public.versions OWNER TO postgres;

--
-- Name: versions_with_users; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "public"."versions_with_users" AS
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


ALTER VIEW public.versions_with_users OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE "realtime"."messages" (
    "topic" "text" NOT NULL,
    "extension" "text" NOT NULL,
    "payload" "jsonb",
    "event" "text",
    "private" boolean DEFAULT false,
    "updated_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "inserted_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL
)
PARTITION BY RANGE ("inserted_at");


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: messages_2025_01_20; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE "realtime"."messages_2025_01_20" (
    "topic" "text" NOT NULL,
    "extension" "text" NOT NULL,
    "payload" "jsonb",
    "event" "text",
    "private" boolean DEFAULT false,
    "updated_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "inserted_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL
);


ALTER TABLE realtime.messages_2025_01_20 OWNER TO supabase_admin;

--
-- Name: messages_2025_01_21; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE "realtime"."messages_2025_01_21" (
    "topic" "text" NOT NULL,
    "extension" "text" NOT NULL,
    "payload" "jsonb",
    "event" "text",
    "private" boolean DEFAULT false,
    "updated_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "inserted_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL
);


ALTER TABLE realtime.messages_2025_01_21 OWNER TO supabase_admin;

--
-- Name: messages_2025_01_22; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE "realtime"."messages_2025_01_22" (
    "topic" "text" NOT NULL,
    "extension" "text" NOT NULL,
    "payload" "jsonb",
    "event" "text",
    "private" boolean DEFAULT false,
    "updated_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "inserted_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL
);


ALTER TABLE realtime.messages_2025_01_22 OWNER TO supabase_admin;

--
-- Name: messages_2025_01_23; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE "realtime"."messages_2025_01_23" (
    "topic" "text" NOT NULL,
    "extension" "text" NOT NULL,
    "payload" "jsonb",
    "event" "text",
    "private" boolean DEFAULT false,
    "updated_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "inserted_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL
);


ALTER TABLE realtime.messages_2025_01_23 OWNER TO supabase_admin;

--
-- Name: messages_2025_01_24; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE "realtime"."messages_2025_01_24" (
    "topic" "text" NOT NULL,
    "extension" "text" NOT NULL,
    "payload" "jsonb",
    "event" "text",
    "private" boolean DEFAULT false,
    "updated_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "inserted_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL
);


ALTER TABLE realtime.messages_2025_01_24 OWNER TO supabase_admin;

--
-- Name: messages_2025_01_25; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE "realtime"."messages_2025_01_25" (
    "topic" "text" NOT NULL,
    "extension" "text" NOT NULL,
    "payload" "jsonb",
    "event" "text",
    "private" boolean DEFAULT false,
    "updated_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "inserted_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL
);


ALTER TABLE realtime.messages_2025_01_25 OWNER TO supabase_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE "realtime"."schema_migrations" (
    "version" bigint NOT NULL,
    "inserted_at" timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE "realtime"."subscription" (
    "id" bigint NOT NULL,
    "subscription_id" "uuid" NOT NULL,
    "entity" "regclass" NOT NULL,
    "filters" "realtime"."user_defined_filter"[] DEFAULT '{}'::"realtime"."user_defined_filter"[] NOT NULL,
    "claims" "jsonb" NOT NULL,
    "claims_role" "regrole" GENERATED ALWAYS AS ("realtime"."to_regrole"(("claims" ->> 'role'::"text"))) STORED NOT NULL,
    "created_at" timestamp without time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE "realtime"."subscription" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "realtime"."subscription_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE "storage"."buckets" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "owner" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "public" boolean DEFAULT false,
    "avif_autodetection" boolean DEFAULT false,
    "file_size_limit" bigint,
    "allowed_mime_types" "text"[],
    "owner_id" "text"
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN "buckets"."owner"; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN "storage"."buckets"."owner" IS 'Field is deprecated, use owner_id instead';


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE "storage"."migrations" (
    "id" integer NOT NULL,
    "name" character varying(100) NOT NULL,
    "hash" character varying(40) NOT NULL,
    "executed_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE "storage"."objects" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "bucket_id" "text",
    "name" "text",
    "owner" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "last_accessed_at" timestamp with time zone DEFAULT "now"(),
    "metadata" "jsonb",
    "path_tokens" "text"[] GENERATED ALWAYS AS ("string_to_array"("name", '/'::"text")) STORED,
    "version" "text",
    "owner_id" "text",
    "user_metadata" "jsonb"
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN "objects"."owner"; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN "storage"."objects"."owner" IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE "storage"."s3_multipart_uploads" (
    "id" "text" NOT NULL,
    "in_progress_size" bigint DEFAULT 0 NOT NULL,
    "upload_signature" "text" NOT NULL,
    "bucket_id" "text" NOT NULL,
    "key" "text" NOT NULL COLLATE "pg_catalog"."C",
    "version" "text" NOT NULL,
    "owner_id" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "user_metadata" "jsonb"
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE "storage"."s3_multipart_uploads_parts" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "upload_id" "text" NOT NULL,
    "size" bigint DEFAULT 0 NOT NULL,
    "part_number" integer NOT NULL,
    "bucket_id" "text" NOT NULL,
    "key" "text" NOT NULL COLLATE "pg_catalog"."C",
    "etag" "text" NOT NULL,
    "owner_id" "text",
    "version" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE "supabase_migrations"."schema_migrations" (
    "version" "text" NOT NULL,
    "statements" "text"[],
    "name" "text"
);


ALTER TABLE supabase_migrations.schema_migrations OWNER TO postgres;

--
-- Name: seed_files; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE "supabase_migrations"."seed_files" (
    "path" "text" NOT NULL,
    "hash" "text" NOT NULL
);


ALTER TABLE supabase_migrations.seed_files OWNER TO postgres;

--
-- Name: decrypted_secrets; Type: VIEW; Schema: vault; Owner: supabase_admin
--

CREATE VIEW "vault"."decrypted_secrets" AS
 SELECT "secrets"."id",
    "secrets"."name",
    "secrets"."description",
    "secrets"."secret",
        CASE
            WHEN ("secrets"."secret" IS NULL) THEN NULL::"text"
            ELSE
            CASE
                WHEN ("secrets"."key_id" IS NULL) THEN NULL::"text"
                ELSE "convert_from"("pgsodium"."crypto_aead_det_decrypt"("decode"("secrets"."secret", 'base64'::"text"), "convert_to"((((("secrets"."id")::"text" || "secrets"."description") || ("secrets"."created_at")::"text") || ("secrets"."updated_at")::"text"), 'utf8'::"name"), "secrets"."key_id", "secrets"."nonce"), 'utf8'::"name")
            END
        END AS "decrypted_secret",
    "secrets"."key_id",
    "secrets"."nonce",
    "secrets"."created_at",
    "secrets"."updated_at"
   FROM "vault"."secrets";


ALTER VIEW vault.decrypted_secrets OWNER TO supabase_admin;

--
-- Name: messages_2025_01_20; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY "realtime"."messages" ATTACH PARTITION "realtime"."messages_2025_01_20" FOR VALUES FROM ('2025-01-20 00:00:00') TO ('2025-01-21 00:00:00');


--
-- Name: messages_2025_01_21; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY "realtime"."messages" ATTACH PARTITION "realtime"."messages_2025_01_21" FOR VALUES FROM ('2025-01-21 00:00:00') TO ('2025-01-22 00:00:00');


--
-- Name: messages_2025_01_22; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY "realtime"."messages" ATTACH PARTITION "realtime"."messages_2025_01_22" FOR VALUES FROM ('2025-01-22 00:00:00') TO ('2025-01-23 00:00:00');


--
-- Name: messages_2025_01_23; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY "realtime"."messages" ATTACH PARTITION "realtime"."messages_2025_01_23" FOR VALUES FROM ('2025-01-23 00:00:00') TO ('2025-01-24 00:00:00');


--
-- Name: messages_2025_01_24; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY "realtime"."messages" ATTACH PARTITION "realtime"."messages_2025_01_24" FOR VALUES FROM ('2025-01-24 00:00:00') TO ('2025-01-25 00:00:00');


--
-- Name: messages_2025_01_25; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY "realtime"."messages" ATTACH PARTITION "realtime"."messages_2025_01_25" FOR VALUES FROM ('2025-01-25 00:00:00') TO ('2025-01-26 00:00:00');


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."refresh_tokens" ALTER COLUMN "id" SET DEFAULT "nextval"('"auth"."refresh_tokens_id_seq"'::"regclass");


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") FROM stdin;
00000000-0000-0000-0000-000000000000	9bc763f5-14cb-4b73-99f2-bab5e6b57946	{"action":"user_confirmation_requested","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-01-21 20:41:34.801954+00	
00000000-0000-0000-0000-000000000000	79c960d0-2069-4055-b3e5-9253c6cfb088	{"action":"user_signedup","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-01-21 20:41:49.760521+00	
00000000-0000-0000-0000-000000000000	e0d4dcd9-ed56-424c-b673-60105b2bb62d	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 20:41:52.35854+00	
00000000-0000-0000-0000-000000000000	a8b8cba8-4576-457d-9a21-991b60e8928d	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 20:42:02.693203+00	
00000000-0000-0000-0000-000000000000	92872c7c-4083-46a5-8838-029f9c54d375	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 20:42:14.761008+00	
00000000-0000-0000-0000-000000000000	28d64d5c-a43b-42e4-9dde-4db7025a84b9	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 20:42:21.986553+00	
00000000-0000-0000-0000-000000000000	a5a9b9cb-89f7-4d8d-a303-53d7c9c71f93	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 20:42:30.123186+00	
00000000-0000-0000-0000-000000000000	4abd12d8-322a-4aab-8821-13bbc673ef72	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:02:47.726157+00	
00000000-0000-0000-0000-000000000000	46296988-7339-413b-a785-53981dc836e1	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:02:50.886018+00	
00000000-0000-0000-0000-000000000000	34ab02bf-1184-4e9b-bcc6-d4f2b5295f0a	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:03:33.293179+00	
00000000-0000-0000-0000-000000000000	e2399303-e104-4b33-93ad-34ef550ec4d4	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:07:01.371459+00	
00000000-0000-0000-0000-000000000000	b9ba28b6-1a4b-4ccd-8172-7cf7015c3d4f	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:08:29.565742+00	
00000000-0000-0000-0000-000000000000	14876bbc-8b9f-449c-812c-e10d7cfb4ce1	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:08:37.764165+00	
00000000-0000-0000-0000-000000000000	4d883a30-3484-4f1b-ae35-2cf09ad7dd45	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:08:41.625074+00	
00000000-0000-0000-0000-000000000000	49609d7f-00af-4c1c-9a79-1b3cac074804	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:08:52.33273+00	
00000000-0000-0000-0000-000000000000	8bbc0b01-8b04-449b-974b-df6a0c98f262	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:09:48.533335+00	
00000000-0000-0000-0000-000000000000	6a1a677d-bd54-4ebe-ac18-4a0e8ea3334c	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:10:49.963417+00	
00000000-0000-0000-0000-000000000000	49d4fa33-e706-454e-b553-e91d13712df5	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:11:39.436215+00	
00000000-0000-0000-0000-000000000000	77adfb34-ebc6-4ca5-82df-7ee0c9b89894	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:13:17.906262+00	
00000000-0000-0000-0000-000000000000	b7bcc386-ad95-4deb-b3c0-16806f389634	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:14:18.289574+00	
00000000-0000-0000-0000-000000000000	3731759f-b94c-4db6-99c3-b180c6c374db	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:15:16.355208+00	
00000000-0000-0000-0000-000000000000	a8d98ffb-9c86-4f9a-bd94-8cb813521f50	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:15:27.203778+00	
00000000-0000-0000-0000-000000000000	474f51f3-2854-490c-8bb2-f52fa7b08c0b	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:15:44.639662+00	
00000000-0000-0000-0000-000000000000	223b20f9-5c5a-47fd-837d-d99e637915ea	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:24:03.410413+00	
00000000-0000-0000-0000-000000000000	db2937a0-63d1-40c7-a55f-8ffa9830338b	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:24:41.736526+00	
00000000-0000-0000-0000-000000000000	3e4a50eb-66dc-4930-bb89-30ed93860d18	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:25:05.499742+00	
00000000-0000-0000-0000-000000000000	62b40b1e-b1cf-4dbe-9148-67969f6dab62	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:26:28.919904+00	
00000000-0000-0000-0000-000000000000	a8cbf91d-befb-403d-93ce-4e436b193e54	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:26:50.124807+00	
00000000-0000-0000-0000-000000000000	6044874f-5fc0-4a32-84c1-b8e38c029768	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:27:12.450228+00	
00000000-0000-0000-0000-000000000000	8f6870e5-97d6-48b0-ad92-417c0582d3ed	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:27:20.946885+00	
00000000-0000-0000-0000-000000000000	28c9e715-b15f-413c-9372-a4079c3ab1c4	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:27:28.615496+00	
00000000-0000-0000-0000-000000000000	986d7410-12a6-434b-9cda-23634deff0fb	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:27:43.438977+00	
00000000-0000-0000-0000-000000000000	7907d6f7-ed61-4c76-81c2-ee62366302f4	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:28:14.901104+00	
00000000-0000-0000-0000-000000000000	318b9088-7bda-4f5d-ac0d-252bcc789fec	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:28:21.554069+00	
00000000-0000-0000-0000-000000000000	20263ace-6cbd-42ad-ab29-706bd8040d3f	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:37:41.126129+00	
00000000-0000-0000-0000-000000000000	39b361d3-9559-4a89-8066-08fc755d7a6b	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:37:53.846179+00	
00000000-0000-0000-0000-000000000000	a647e390-c703-4e87-a7d4-cdf916f55daa	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:38:05.557435+00	
00000000-0000-0000-0000-000000000000	381419ef-7ce9-440f-9119-945b0c69c96d	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:38:37.233245+00	
00000000-0000-0000-0000-000000000000	fbf98ec1-5b43-4d92-8a5b-09a0390d4153	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:39:05.349273+00	
00000000-0000-0000-0000-000000000000	90ab3641-fb14-40b2-a3be-955a3241e4f2	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:40:14.225257+00	
00000000-0000-0000-0000-000000000000	2b78bb98-d7f6-4242-8212-ce93f2c9a6b5	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:40:37.855584+00	
00000000-0000-0000-0000-000000000000	56e29e67-2e3b-4637-a785-0ca5c619c893	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:40:59.705054+00	
00000000-0000-0000-0000-000000000000	b76fb14e-aef9-4d87-8d89-433e639a32a9	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:43:14.582485+00	
00000000-0000-0000-0000-000000000000	fa9c90fb-bce6-4ca9-a36a-39dcb1d15c29	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:48:39.802668+00	
00000000-0000-0000-0000-000000000000	d7da7e80-7391-44fd-96a7-4033e16c54f9	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:51:25.941953+00	
00000000-0000-0000-0000-000000000000	5f56fe81-2a54-482e-8917-75915b5d91f3	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:51:40.322423+00	
00000000-0000-0000-0000-000000000000	a30c081b-4352-48eb-b5c1-00da4f8230b5	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:52:00.757669+00	
00000000-0000-0000-0000-000000000000	96296562-197b-4212-9118-b903e8a4105c	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:52:24.028501+00	
00000000-0000-0000-0000-000000000000	cfd42885-55d2-4547-a296-edd700cc19c4	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:52:44.827885+00	
00000000-0000-0000-0000-000000000000	d419e425-8a32-4148-b6ff-006c463ef4cd	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:54:12.502524+00	
00000000-0000-0000-0000-000000000000	b83e21e9-01e8-4575-97ad-ada81a3dc878	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 21:56:04.332679+00	
00000000-0000-0000-0000-000000000000	96112280-574f-4072-973e-8f2f00250336	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-21 22:09:37.577113+00	
00000000-0000-0000-0000-000000000000	949e50f0-031e-4205-aee4-561c686c0d32	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:10:01.998242+00	
00000000-0000-0000-0000-000000000000	c0959241-a9b5-47f7-b027-1a54e8ecc7f4	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:15:45.397818+00	
00000000-0000-0000-0000-000000000000	16b8f3da-1ab2-41f1-b9e0-fc1bca83328f	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:15:51.037779+00	
00000000-0000-0000-0000-000000000000	ed83a773-c02c-4a52-9ae6-67343c1db600	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:15:59.615589+00	
00000000-0000-0000-0000-000000000000	1a42a927-9d18-4269-9dc8-5415c86ad204	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:17:05.984901+00	
00000000-0000-0000-0000-000000000000	26dcff88-67c5-46b5-808e-a8dc95fb7b6f	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:18:07.045779+00	
00000000-0000-0000-0000-000000000000	fd99f15b-e146-4d4b-adb3-86d2d6c6d8be	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:18:13.187546+00	
00000000-0000-0000-0000-000000000000	7c55dad3-86bd-4a82-9488-f8789b38a479	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-21 22:18:41.075454+00	
00000000-0000-0000-0000-000000000000	07895557-c97a-4e1b-9e30-751a58dbd5d7	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:18:42.655466+00	
00000000-0000-0000-0000-000000000000	5bbb4789-80fc-489b-a28f-56acca809208	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-21 22:18:49.230112+00	
00000000-0000-0000-0000-000000000000	c0bed6de-b74c-40a5-90ad-a5f03ac706c8	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:18:50.913986+00	
00000000-0000-0000-0000-000000000000	97f2db0e-f549-4443-96b5-8d0bd47e7e87	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:20:00.799662+00	
00000000-0000-0000-0000-000000000000	726dc9cd-52db-4dca-bd97-59c33048ce29	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:21:56.743597+00	
00000000-0000-0000-0000-000000000000	6a1f46e4-c835-4dfd-90e6-a354cd434c90	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:21:59.300575+00	
00000000-0000-0000-0000-000000000000	d45ae45a-1076-4e6d-9b3d-b468d9f70edf	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:24:07.447148+00	
00000000-0000-0000-0000-000000000000	b35f42c8-4316-4a5c-ae6f-5f225dcb099e	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:24:10.61321+00	
00000000-0000-0000-0000-000000000000	278ee0e3-d986-4f0c-abd3-9124699d082f	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:26:03.854955+00	
00000000-0000-0000-0000-000000000000	51959cde-32dd-43f2-be38-761dc163ff1e	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:26:07.116315+00	
00000000-0000-0000-0000-000000000000	ab56dea3-b35e-4008-8787-ce54a6cdbe62	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:26:15.335617+00	
00000000-0000-0000-0000-000000000000	785eaaf4-5b85-4f0b-b37b-41287e1e9805	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:28:11.836035+00	
00000000-0000-0000-0000-000000000000	0dcae0ae-a126-4934-bab9-b3633ed508b4	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:41:01.747928+00	
00000000-0000-0000-0000-000000000000	b781f765-7c39-41e0-8389-607070671299	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 22:42:09.973177+00	
00000000-0000-0000-0000-000000000000	d66de9b8-8688-45d8-90e4-30596994e0b5	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 23:06:29.409359+00	
00000000-0000-0000-0000-000000000000	310f9ae0-4971-4d2d-b872-47161d23bc7d	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 23:09:35.969042+00	
00000000-0000-0000-0000-000000000000	01591290-f510-4e9f-8b72-3afbaa119a19	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-21 23:16:58.055347+00	
00000000-0000-0000-0000-000000000000	21353157-0908-4387-9a92-30e8cb66a04a	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 23:16:59.952752+00	
00000000-0000-0000-0000-000000000000	4c86ded4-1ac1-4a94-9f2a-b7d7ae06ae9d	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 23:18:32.383959+00	
00000000-0000-0000-0000-000000000000	89fa3335-c202-47c8-9be7-3ed891e74671	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 23:24:42.832501+00	
00000000-0000-0000-0000-000000000000	8aa3c6b5-c0c9-49b5-91cd-227c06316de5	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 23:29:25.388416+00	
00000000-0000-0000-0000-000000000000	92a570a7-f0ba-489b-ac57-2811c15b03ae	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 23:30:18.646577+00	
00000000-0000-0000-0000-000000000000	438b23b2-ee21-4c3a-adbb-3ce394a9c441	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 23:31:13.536278+00	
00000000-0000-0000-0000-000000000000	ddd6930e-805f-47a6-80af-02e1c9a4c926	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 23:31:52.770679+00	
00000000-0000-0000-0000-000000000000	44aec69f-9827-4076-b134-587f568ec60a	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 23:32:49.650035+00	
00000000-0000-0000-0000-000000000000	f5ae5773-b455-47b4-9fb2-e80d51d5ef7d	{"action":"user_confirmation_requested","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-01-21 23:48:43.341012+00	
00000000-0000-0000-0000-000000000000	38de53fb-1bc2-4d6e-99fe-d6ccab9d028b	{"action":"user_signedup","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-01-21 23:48:54.857147+00	
00000000-0000-0000-0000-000000000000	0fc971c5-e6f7-4fa3-a965-f432893db023	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 23:49:02.480325+00	
00000000-0000-0000-0000-000000000000	ed886c80-b430-4726-8ebe-96f0a57ebd1d	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 23:50:30.73921+00	
00000000-0000-0000-0000-000000000000	16876add-c111-47eb-ad9f-64305abf1052	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-21 23:50:51.401107+00	
00000000-0000-0000-0000-000000000000	7a1b3a60-325a-49ec-8ea4-9783d23f40b5	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 00:00:31.43194+00	
00000000-0000-0000-0000-000000000000	97531160-cdc3-4f81-8e95-d4e1ade62bd4	{"action":"user_confirmation_requested","actor_id":"16bfe819-65d8-4e79-a96c-9b82765bd239","actor_username":"joenilan@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-01-22 00:02:58.680899+00	
00000000-0000-0000-0000-000000000000	7935ad58-22a9-40ad-b766-fde455226d11	{"action":"user_signedup","actor_id":"16bfe819-65d8-4e79-a96c-9b82765bd239","actor_username":"joenilan@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-01-22 00:03:05.185359+00	
00000000-0000-0000-0000-000000000000	3f051608-45bc-4b4b-b2bf-1b2cee7ebd8c	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 00:09:27.276176+00	
00000000-0000-0000-0000-000000000000	4b9a12f5-a49e-4b07-b109-de0d4b7d7b5c	{"action":"logout","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-22 00:09:37.516388+00	
00000000-0000-0000-0000-000000000000	dae39cc9-6462-48c7-a669-695e32c28786	{"action":"user_repeated_signup","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-01-22 00:12:05.247307+00	
00000000-0000-0000-0000-000000000000	f69e09e7-a61b-4d0f-9e14-309a5c98082d	{"action":"user_repeated_signup","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-01-22 00:15:06.303673+00	
00000000-0000-0000-0000-000000000000	8fa6a348-7741-46dd-9b9f-8a9877d485e8	{"action":"user_repeated_signup","actor_id":"16bfe819-65d8-4e79-a96c-9b82765bd239","actor_username":"joenilan@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-01-22 00:17:38.708761+00	
00000000-0000-0000-0000-000000000000	0d4f79f1-8391-4520-bfbd-6d28e2c85d3f	{"action":"login","actor_id":"16bfe819-65d8-4e79-a96c-9b82765bd239","actor_username":"joenilan@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 00:17:42.87602+00	
00000000-0000-0000-0000-000000000000	5381242e-eda4-4572-bd7a-89524f827033	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 00:18:30.523765+00	
00000000-0000-0000-0000-000000000000	46d35124-0c87-43f5-8b27-74dca215ed49	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 00:23:48.790927+00	
00000000-0000-0000-0000-000000000000	557bd1bf-68c0-42b9-97ac-749b7cfd1036	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 00:38:12.522853+00	
00000000-0000-0000-0000-000000000000	1d64db69-717d-46c8-a0f8-424435634c12	{"action":"user_confirmation_requested","actor_id":"5e439340-f634-4871-bdc0-1fd7748ec3c9","actor_username":"gaytan2012@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-01-22 00:38:39.313753+00	
00000000-0000-0000-0000-000000000000	86ebaba7-0043-4790-97ff-568ad4266694	{"action":"user_signedup","actor_id":"5e439340-f634-4871-bdc0-1fd7748ec3c9","actor_username":"gaytan2012@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-01-22 00:38:52.146814+00	
00000000-0000-0000-0000-000000000000	5d992f19-24aa-4855-b7e6-f14d536cbeee	{"action":"login","actor_id":"5e439340-f634-4871-bdc0-1fd7748ec3c9","actor_username":"gaytan2012@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 00:39:01.139742+00	
00000000-0000-0000-0000-000000000000	3b4e1437-5744-440a-9ee4-32e3012ed8cf	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 00:55:32.3003+00	
00000000-0000-0000-0000-000000000000	160ebbac-d544-4926-94ad-e4dc937bb6d4	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 01:04:48.669865+00	
00000000-0000-0000-0000-000000000000	ad6bc4cb-b608-425f-b255-f62eb59e249b	{"action":"login","actor_id":"5e439340-f634-4871-bdc0-1fd7748ec3c9","actor_username":"gaytan2012@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 01:05:31.669412+00	
00000000-0000-0000-0000-000000000000	c5ef5b91-1d2f-41b4-9653-b7c3e7b144f4	{"action":"logout","actor_id":"16bfe819-65d8-4e79-a96c-9b82765bd239","actor_username":"joenilan@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-22 01:13:04.752829+00	
00000000-0000-0000-0000-000000000000	21e59c65-264d-4af4-b288-55f1a7f89efc	{"action":"login","actor_id":"5e439340-f634-4871-bdc0-1fd7748ec3c9","actor_username":"gaytan2012@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 01:32:57.17007+00	
00000000-0000-0000-0000-000000000000	9b6a0459-d126-448c-b64f-95c91da6da1c	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 01:39:36.65389+00	
00000000-0000-0000-0000-000000000000	00d7154a-94e4-45d5-9462-13706b7950d9	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 01:39:42.868302+00	
00000000-0000-0000-0000-000000000000	e9a4c486-c8e6-4ddd-8467-52c735231cf7	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 01:39:47.894004+00	
00000000-0000-0000-0000-000000000000	49ade430-7ff8-414d-9ae7-a2aebb339014	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 01:43:59.328531+00	
00000000-0000-0000-0000-000000000000	fdf46cf0-0831-46cf-b2ac-a6361e97668a	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 01:47:39.393939+00	
00000000-0000-0000-0000-000000000000	415a7108-6c74-4b33-a07a-0a166da630f8	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 01:51:08.367141+00	
00000000-0000-0000-0000-000000000000	6915023a-5c9e-4626-83d3-27fe5c593c81	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 01:54:11.415675+00	
00000000-0000-0000-0000-000000000000	6757cc4f-218c-469b-a4ea-67468862b7de	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 01:55:35.05578+00	
00000000-0000-0000-0000-000000000000	81c8d99f-14a3-4457-8fcf-e6d144929822	{"action":"logout","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-22 02:00:50.165953+00	
00000000-0000-0000-0000-000000000000	83a42a28-2685-47ec-982a-29869be60b59	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:01:37.90291+00	
00000000-0000-0000-0000-000000000000	791ab490-1f13-4c87-b524-4aba868d5c79	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:01:58.774738+00	
00000000-0000-0000-0000-000000000000	14f3bf5b-3524-477f-8288-62d5daf02812	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:04:34.5929+00	
00000000-0000-0000-0000-000000000000	42ac1962-71ec-4503-9657-c618e0755c79	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:04:56.538737+00	
00000000-0000-0000-0000-000000000000	63fbbe60-584f-49c7-b4cb-8c285bdec9c1	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:05:30.629849+00	
00000000-0000-0000-0000-000000000000	3233eca3-44a0-4bf0-99b4-29588367728e	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:07:06.324037+00	
00000000-0000-0000-0000-000000000000	188c171c-d6a4-46d2-9d2e-de3f472b8d38	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:07:20.058385+00	
00000000-0000-0000-0000-000000000000	df106803-ace7-43d0-8246-e62d30bcd59b	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:10:12.458824+00	
00000000-0000-0000-0000-000000000000	8c3e6d72-401f-408b-b5be-31abe5474c54	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:11:45.739105+00	
00000000-0000-0000-0000-000000000000	bb562203-3414-4159-af9a-adb367737a6b	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:15:26.994482+00	
00000000-0000-0000-0000-000000000000	71ed7ee9-08ee-4f14-861d-28dfa53ab3ec	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:15:44.870538+00	
00000000-0000-0000-0000-000000000000	2bb9a71d-f332-47eb-b47e-5139da742725	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:17:16.137038+00	
00000000-0000-0000-0000-000000000000	bd083ec5-b0d2-490b-b470-8919f4392708	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:17:38.639124+00	
00000000-0000-0000-0000-000000000000	795e547c-9f84-4378-9e34-0571db39f78e	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:17:52.727066+00	
00000000-0000-0000-0000-000000000000	3ecb1728-5516-48a2-aade-8897fa416b25	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:19:15.717412+00	
00000000-0000-0000-0000-000000000000	548b342d-29ab-4503-becb-48ac1cab25c2	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:19:32.902891+00	
00000000-0000-0000-0000-000000000000	db7f074d-e6e2-4388-92ab-4d42b5fd89eb	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:19:40.432885+00	
00000000-0000-0000-0000-000000000000	5cf3b565-d572-49c7-9264-ccb3a53b2daa	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:20:34.009538+00	
00000000-0000-0000-0000-000000000000	861f99e2-fa4b-45e8-99f6-995c981a4ec7	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:20:37.482239+00	
00000000-0000-0000-0000-000000000000	29bfa8d5-afb2-414d-a0c5-b717aca58c55	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:24:24.886275+00	
00000000-0000-0000-0000-000000000000	6638b828-ddcb-4d16-8fba-f721e41d867c	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:24:35.71947+00	
00000000-0000-0000-0000-000000000000	88fa9785-a1de-446c-be70-c0fabb2b5e19	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:25:47.304354+00	
00000000-0000-0000-0000-000000000000	973c9094-c2d7-46d8-9db6-8b30e104c4be	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:25:53.045311+00	
00000000-0000-0000-0000-000000000000	bb6ee7c1-e0c2-4b68-97a7-52ec205817ca	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-22 02:26:37.863452+00	
00000000-0000-0000-0000-000000000000	5a3205ad-86a5-4911-b48a-dedcc0c8afe4	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:26:39.626035+00	
00000000-0000-0000-0000-000000000000	488213f6-5ca4-4ed9-8c88-49d6f7afed44	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-22 02:27:25.533957+00	
00000000-0000-0000-0000-000000000000	b8c6de6c-b191-465c-ab2b-056ed20f2e76	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:27:27.103423+00	
00000000-0000-0000-0000-000000000000	788cccab-1026-4b68-a8f9-b92392989d72	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:28:05.554748+00	
00000000-0000-0000-0000-000000000000	1bf59eb5-c3b0-4fe7-a023-eb9eeedd9885	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-22 02:28:14.089716+00	
00000000-0000-0000-0000-000000000000	36b4a882-e1ea-4805-8c32-a7200bb9ed39	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:28:27.392769+00	
00000000-0000-0000-0000-000000000000	408126d8-ac2b-4b60-af7f-2124afb8a83e	{"action":"logout","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-22 02:29:03.472357+00	
00000000-0000-0000-0000-000000000000	096d1d30-1b75-4add-9b51-ee5538528941	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:29:06.18468+00	
00000000-0000-0000-0000-000000000000	62e7edb8-71f6-4976-b9ea-a5fa361d8d03	{"action":"token_refreshed","actor_id":"5e439340-f634-4871-bdc0-1fd7748ec3c9","actor_username":"gaytan2012@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 02:33:56.02569+00	
00000000-0000-0000-0000-000000000000	8b9235eb-8216-45c8-af96-e4ab88a9e8fd	{"action":"token_revoked","actor_id":"5e439340-f634-4871-bdc0-1fd7748ec3c9","actor_username":"gaytan2012@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 02:33:56.026688+00	
00000000-0000-0000-0000-000000000000	c3cbf26a-5b1d-498d-96f1-37645e54d183	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:34:05.873459+00	
00000000-0000-0000-0000-000000000000	c0640046-86d0-432a-8d41-094be9d5444a	{"action":"login","actor_id":"5e439340-f634-4871-bdc0-1fd7748ec3c9","actor_username":"gaytan2012@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:34:08.449899+00	
00000000-0000-0000-0000-000000000000	bace7778-22de-4c82-a32b-73d00dfeebaf	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:35:56.624388+00	
00000000-0000-0000-0000-000000000000	5fdea396-2310-4856-81c4-945a772d7b4b	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:36:35.662602+00	
00000000-0000-0000-0000-000000000000	55060e2d-6f7e-4153-9c7b-8f8830d67658	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:40:41.922983+00	
00000000-0000-0000-0000-000000000000	275122d0-f586-446c-91e2-a693ad553ea5	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:41:06.937289+00	
00000000-0000-0000-0000-000000000000	12001e10-5ef1-4524-b135-ccad427e2290	{"action":"login","actor_id":"5e439340-f634-4871-bdc0-1fd7748ec3c9","actor_username":"gaytan2012@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:45:33.953492+00	
00000000-0000-0000-0000-000000000000	875eca04-609c-4123-b418-40d02c18699f	{"action":"login","actor_id":"5e439340-f634-4871-bdc0-1fd7748ec3c9","actor_username":"gaytan2012@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:46:29.387311+00	
00000000-0000-0000-0000-000000000000	39f95985-1dd9-4fc5-ae9b-9919985c88bf	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 02:48:33.403302+00	
00000000-0000-0000-0000-000000000000	94165c34-090d-4908-89fe-3a8e5bbe8b2a	{"action":"login","actor_id":"5e439340-f634-4871-bdc0-1fd7748ec3c9","actor_username":"gaytan2012@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 03:05:10.149253+00	
00000000-0000-0000-0000-000000000000	efc72d1c-306f-40c2-abe7-0c9e4a9f6d1d	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 03:27:34.180075+00	
00000000-0000-0000-0000-000000000000	c346ed99-3b24-4cf7-89b0-557232284664	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 03:27:34.18338+00	
00000000-0000-0000-0000-000000000000	762701c2-4b3c-41a4-a361-19e57b43801a	{"action":"token_refreshed","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 03:47:01.457688+00	
00000000-0000-0000-0000-000000000000	8e4e086e-cc41-4113-a5cc-0bdf92956fcb	{"action":"token_revoked","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 03:47:01.458583+00	
00000000-0000-0000-0000-000000000000	db323090-65a3-4a72-855c-6370632fb81f	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 04:26:04.103187+00	
00000000-0000-0000-0000-000000000000	412f1fc1-c9a4-4f84-92f3-f937d58e57a9	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 04:26:04.104164+00	
00000000-0000-0000-0000-000000000000	041cdc2b-a99a-4b86-89a9-29dcdc07054d	{"action":"token_refreshed","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 04:45:31.351428+00	
00000000-0000-0000-0000-000000000000	acd03b1a-2f54-425d-8e65-4b183bdcae32	{"action":"token_revoked","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 04:45:31.352409+00	
00000000-0000-0000-0000-000000000000	71181afa-2efa-4450-ad4e-d5f5518ada83	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 05:24:34.141991+00	
00000000-0000-0000-0000-000000000000	a4d33eb5-78a1-4b82-a47f-17949973fa8d	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 05:24:34.144828+00	
00000000-0000-0000-0000-000000000000	1807a977-b747-4f08-a737-3cecdfd9bafc	{"action":"token_refreshed","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 05:44:01.396626+00	
00000000-0000-0000-0000-000000000000	35860297-5b3a-4cdb-a833-81fd6962670a	{"action":"token_revoked","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 05:44:01.397478+00	
00000000-0000-0000-0000-000000000000	32731765-48a9-48cc-be61-806cc0c6de91	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 06:15:53.77449+00	
00000000-0000-0000-0000-000000000000	cd3f31d0-6397-421c-a17d-ad0d03827500	{"action":"logout","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-22 06:21:51.555248+00	
00000000-0000-0000-0000-000000000000	8cc2f1db-a4a4-4f5e-a179-a23c39d1209a	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 06:22:03.506748+00	
00000000-0000-0000-0000-000000000000	858b685f-9d44-43ab-93b6-4101b6246491	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 06:23:04.031171+00	
00000000-0000-0000-0000-000000000000	7220a9d2-251d-4bad-bea0-752998f51630	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 06:23:04.032081+00	
00000000-0000-0000-0000-000000000000	acba0c7a-480b-42db-8ef9-d9be8f208fe2	{"action":"token_refreshed","actor_id":"5e439340-f634-4871-bdc0-1fd7748ec3c9","actor_username":"gaytan2012@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 06:32:52.931284+00	
00000000-0000-0000-0000-000000000000	359e1363-3f5d-4bf3-9805-4c3b271ca2d4	{"action":"token_revoked","actor_id":"5e439340-f634-4871-bdc0-1fd7748ec3c9","actor_username":"gaytan2012@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-22 06:32:52.933928+00	
00000000-0000-0000-0000-000000000000	1092b889-5238-44ec-896b-812b07a56a35	{"action":"login","actor_id":"5e439340-f634-4871-bdc0-1fd7748ec3c9","actor_username":"gaytan2012@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 06:33:55.915201+00	
00000000-0000-0000-0000-000000000000	53ac93e1-6a39-4944-a390-8a31fb140387	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-22 06:47:27.328538+00	
00000000-0000-0000-0000-000000000000	8b1e331e-5aea-44f8-8693-9476adbae5fe	{"action":"user_confirmation_requested","actor_id":"f3fbf22b-ce0f-4af9-85a2-ea2f88a9cb85","actor_username":"nickolasheisler@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-01-22 11:48:26.339+00	
00000000-0000-0000-0000-000000000000	07f86cda-f73a-4daa-bcab-efc531a186b1	{"action":"user_signedup","actor_id":"f3fbf22b-ce0f-4af9-85a2-ea2f88a9cb85","actor_username":"nickolasheisler@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-01-22 11:48:44.764642+00	
00000000-0000-0000-0000-000000000000	e3f5886c-909b-4986-9887-cc64c03556bb	{"action":"login","actor_id":"f3fbf22b-ce0f-4af9-85a2-ea2f88a9cb85","actor_username":"nickolasheisler@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-22 11:48:51.37194+00	
00000000-0000-0000-0000-000000000000	40f8b395-5643-40d7-a68f-6b782c6d28b1	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 05:07:50.643224+00	
00000000-0000-0000-0000-000000000000	257a34de-a70d-45b2-a5d3-be0b67c74181	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-23 05:11:34.537374+00	
00000000-0000-0000-0000-000000000000	93820dfe-55f8-412a-9bee-d1546ddabfba	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 05:20:59.835749+00	
00000000-0000-0000-0000-000000000000	0d5dea84-c468-4aea-8078-6ba0af46a71a	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 05:44:00.441021+00	
00000000-0000-0000-0000-000000000000	3b1daab9-96aa-4480-97e9-8e7e5f0bc210	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-23 05:44:02.474122+00	
00000000-0000-0000-0000-000000000000	1e6beead-1201-481b-b163-2ea8c6b81abf	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 06:04:19.586619+00	
00000000-0000-0000-0000-000000000000	c42fee54-3536-4d42-b643-62fddfaab8db	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-23 06:04:21.992722+00	
00000000-0000-0000-0000-000000000000	af57d438-0654-454b-bd63-b1caa614e81d	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"discord"}}	2025-01-23 07:54:37.745343+00	
00000000-0000-0000-0000-000000000000	c25663b5-ae74-4aa8-9c10-2510e0b0e016	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"discord"}}	2025-01-23 08:02:13.262552+00	
00000000-0000-0000-0000-000000000000	7d8db9c6-9b7d-44c2-9ebe-f291fa382b52	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"discord"}}	2025-01-23 08:08:09.109786+00	
00000000-0000-0000-0000-000000000000	20ae4e81-1c23-499b-822d-1d6b6839f1b9	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"discord"}}	2025-01-23 08:10:19.792567+00	
00000000-0000-0000-0000-000000000000	0447980d-ba4f-490b-8d20-ce90e57e8af8	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"discord"}}	2025-01-23 08:17:11.25948+00	
00000000-0000-0000-0000-000000000000	5dbf948e-c046-4feb-9367-4ca4f4194676	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"discord"}}	2025-01-23 08:19:16.114497+00	
00000000-0000-0000-0000-000000000000	4d82652d-1cb2-4e3d-abca-cdaf0d011a96	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"discord"}}	2025-01-23 08:29:17.330972+00	
00000000-0000-0000-0000-000000000000	aa990d3b-0c08-412c-95d8-363ce110c3e9	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"discord"}}	2025-01-23 08:29:59.479943+00	
00000000-0000-0000-0000-000000000000	2c838692-12e7-4411-ac6f-bbdd2bb940e6	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"discord"}}	2025-01-23 08:32:16.912332+00	
00000000-0000-0000-0000-000000000000	ac874df3-1141-43b4-872c-b72095241727	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:32:36.633758+00	
00000000-0000-0000-0000-000000000000	e21bbfa3-f775-4603-b7b5-9602ee425aef	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:32:41.253481+00	
00000000-0000-0000-0000-000000000000	f98b2462-4dfa-4374-ab85-cc368e737503	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"discord"}}	2025-01-23 08:32:56.26475+00	
00000000-0000-0000-0000-000000000000	18316730-3144-4af5-85c6-0ccf887a8bfe	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:32:59.474391+00	
00000000-0000-0000-0000-000000000000	76f7da96-c949-48af-9c86-257b7db6094b	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:35:41.027165+00	
00000000-0000-0000-0000-000000000000	d40a0fd3-6853-4e00-a706-b574541c59cb	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:35:42.509767+00	
00000000-0000-0000-0000-000000000000	c2cf54c3-dc09-4365-905d-da9993211a92	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:36:21.397647+00	
00000000-0000-0000-0000-000000000000	3d02903a-cfb4-442f-ac97-074178746b1d	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:36:33.118956+00	
00000000-0000-0000-0000-000000000000	8dd0ed74-caec-4985-8187-11c6b22ac3c4	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:36:41.637981+00	
00000000-0000-0000-0000-000000000000	cf2302e4-9d3a-4240-a16a-58b9aa7d2ff7	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:41:47.079044+00	
00000000-0000-0000-0000-000000000000	97cbe46c-a189-42b6-a226-98135c90f942	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:41:56.238696+00	
00000000-0000-0000-0000-000000000000	be2a980d-c4d6-4eb2-94f4-4b168684f407	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:43:20.839299+00	
00000000-0000-0000-0000-000000000000	a7f8cd35-460c-40a4-85c9-d175cd3fcf50	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:47:25.543638+00	
00000000-0000-0000-0000-000000000000	ae0554e5-b884-4fb9-8196-745abb4b3754	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:49:54.645387+00	
00000000-0000-0000-0000-000000000000	404a130f-38bb-4186-b371-8c5b3408ef60	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:49:59.458+00	
00000000-0000-0000-0000-000000000000	3361c503-284e-46b2-ae15-fb20d9e68896	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:51:31.501572+00	
00000000-0000-0000-0000-000000000000	443671f5-d216-45f6-9db5-ce4ff36ee7a9	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:51:42.684419+00	
00000000-0000-0000-0000-000000000000	9a00d4e1-4c73-48df-9292-10dec03ecabc	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:51:48.779046+00	
00000000-0000-0000-0000-000000000000	5e2c3246-ab63-4048-86b4-be4c2037be26	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:54:25.441381+00	
00000000-0000-0000-0000-000000000000	22b631d9-e1de-48ab-b7bd-832248f73027	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:55:36.936489+00	
00000000-0000-0000-0000-000000000000	760571e0-1ce1-4a39-b22a-2d62edd62f4a	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:56:27.127577+00	
00000000-0000-0000-0000-000000000000	9a400227-6210-4283-8b0f-2a9fa9d10318	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:59:42.55277+00	
00000000-0000-0000-0000-000000000000	42cb07b1-f24a-4d44-b63f-058059a02638	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 08:59:51.944156+00	
00000000-0000-0000-0000-000000000000	6948405e-fe1b-4d75-9935-efd58e04f286	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 09:08:15.678706+00	
00000000-0000-0000-0000-000000000000	a4116c6b-e7ae-4423-82cf-de7fd5e15c45	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 09:11:31.696321+00	
00000000-0000-0000-0000-000000000000	1b56c839-6b05-4c3b-8c23-09d4ebaf6eb8	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 09:19:50.501592+00	
00000000-0000-0000-0000-000000000000	b25a456a-049a-48f7-ad4b-dc7ccecf5d72	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 09:19:56.005821+00	
00000000-0000-0000-0000-000000000000	d3c8c809-5b8d-46d6-a115-7801e62428ca	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 09:21:01.759674+00	
00000000-0000-0000-0000-000000000000	2844e538-e038-48da-9772-5aa61240b74f	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"discord"}}	2025-01-23 09:21:13.222682+00	
00000000-0000-0000-0000-000000000000	54e0e3b7-8b03-4cf5-b08a-533053dce3bc	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 09:21:17.428671+00	
00000000-0000-0000-0000-000000000000	1166c867-da2d-4c0f-9ee4-cf74f2744766	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 09:46:21.146741+00	
00000000-0000-0000-0000-000000000000	9d0dc555-64c6-47f6-99d3-e5842fb075ae	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 09:47:11.798163+00	
00000000-0000-0000-0000-000000000000	6ff4bdb5-5558-4d3d-a8a6-ecb32374f1e7	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 09:47:14.800379+00	
00000000-0000-0000-0000-000000000000	6d24b30d-0510-4f1d-b3c8-b0d1ceb4e962	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"discord"}}	2025-01-23 09:48:05.95747+00	
00000000-0000-0000-0000-000000000000	fed3beb5-1edd-472a-886a-5b2fd5f9e031	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 09:48:07.768604+00	
00000000-0000-0000-0000-000000000000	31e686df-71d2-4c1b-98f3-5a1ce1d4732f	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 09:49:16.560451+00	
00000000-0000-0000-0000-000000000000	eb1e6460-54d0-4723-9f6d-cc41ea28ac9c	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 10:33:46.254214+00	
00000000-0000-0000-0000-000000000000	c7f63e3d-7c05-497b-8a35-010e490fb11c	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 10:34:19.583335+00	
00000000-0000-0000-0000-000000000000	e6bd8ce9-3f7a-4b1c-8677-41a307e0efe2	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 10:34:23.18006+00	
00000000-0000-0000-0000-000000000000	5481decc-8ead-4b69-bb5c-f5a466312ef8	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 10:34:35.143288+00	
00000000-0000-0000-0000-000000000000	5497f71e-d903-40a8-9dcc-6a7446e6c601	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 10:35:00.452519+00	
00000000-0000-0000-0000-000000000000	b35797e4-5c88-42b3-8ebe-4c43021eaf38	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 10:36:16.727125+00	
00000000-0000-0000-0000-000000000000	2567f3df-1171-4719-b320-774a02a888fc	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 10:36:27.526478+00	
00000000-0000-0000-0000-000000000000	5b3744a5-44d1-4d5c-99ae-0e0511cf5bc5	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 10:37:13.206519+00	
00000000-0000-0000-0000-000000000000	8e046642-8b67-41b5-bd59-6e3c15308f91	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 10:39:00.432763+00	
00000000-0000-0000-0000-000000000000	2ed95219-531b-474a-8ed6-609d2abbe59d	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 10:40:29.114134+00	
00000000-0000-0000-0000-000000000000	ecd0a93a-c15c-4a64-85d9-61e15bd56245	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 10:40:55.415553+00	
00000000-0000-0000-0000-000000000000	7e706579-d597-46d5-a7a6-62538106a591	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 10:42:38.353442+00	
00000000-0000-0000-0000-000000000000	636b5425-faab-4352-baca-2d8ea04802ac	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 10:43:10.30999+00	
00000000-0000-0000-0000-000000000000	c087a582-5460-4834-9bec-7cfd42ef0841	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 10:45:35.731045+00	
00000000-0000-0000-0000-000000000000	f45aeffb-7cb6-459d-81cd-73393929b31b	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 10:49:11.812065+00	
00000000-0000-0000-0000-000000000000	37a4a5d1-60e3-43fe-bf34-dc54705a69a9	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 10:58:23.487345+00	
00000000-0000-0000-0000-000000000000	5f0bff69-723c-4dbf-8631-593a94e4272c	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 11:00:58.198179+00	
00000000-0000-0000-0000-000000000000	2de32426-b930-4114-aefd-b5f42b2a377f	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 11:27:18.512095+00	
00000000-0000-0000-0000-000000000000	2d032a27-a6d8-4378-97f4-d0256f650529	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 11:34:13.149125+00	
00000000-0000-0000-0000-000000000000	a1f865f6-7234-4026-9c0c-c1796885a702	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 11:55:44.479811+00	
00000000-0000-0000-0000-000000000000	cc897714-2e68-4f18-b8e7-71c502efb7b0	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 11:58:17.648655+00	
00000000-0000-0000-0000-000000000000	857f4833-2fbc-4e57-9a31-c1edca79e5f0	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 12:12:55.114+00	
00000000-0000-0000-0000-000000000000	134023d8-ba54-44cf-b39b-afe8202e7114	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 12:15:20.872428+00	
00000000-0000-0000-0000-000000000000	5b85df18-f193-40c5-a270-c131fb239bc8	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 12:15:29.312088+00	
00000000-0000-0000-0000-000000000000	883e4044-ffa5-4333-a000-ec0d1a9c3924	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 12:16:38.345839+00	
00000000-0000-0000-0000-000000000000	27dd45e9-123b-4bb0-9bc1-b9845d256dc9	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 12:16:41.162013+00	
00000000-0000-0000-0000-000000000000	e8759860-88d7-49f5-9738-acae9515adbc	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 12:17:07.523019+00	
00000000-0000-0000-0000-000000000000	332ce587-6795-43c7-abc0-a2be03d5ea9d	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 12:17:17.913844+00	
00000000-0000-0000-0000-000000000000	f7f7edc6-5929-4d6d-b5b4-f3432d458901	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 12:17:21.077034+00	
00000000-0000-0000-0000-000000000000	1bc121fe-bfd0-46d4-9e41-bedc4e080527	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 12:17:33.250871+00	
00000000-0000-0000-0000-000000000000	5eebf0bc-3020-43c2-ac6d-426f6cc4f905	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 12:17:49.521879+00	
00000000-0000-0000-0000-000000000000	f2fd462f-2d5c-4f90-903a-ba2bbb965207	{"action":"token_refreshed","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-23 15:03:50.683891+00	
00000000-0000-0000-0000-000000000000	3f273a79-8fa4-4929-aeae-3b72676cc5b7	{"action":"token_revoked","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-23 15:03:50.692338+00	
00000000-0000-0000-0000-000000000000	637502d8-9729-44c8-9ab3-28923e401236	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-23 15:04:04.89438+00	
00000000-0000-0000-0000-000000000000	1a58e509-2048-4f1f-a9a7-09cfa58244bc	{"action":"token_refreshed","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-23 18:40:10.58885+00	
00000000-0000-0000-0000-000000000000	eaee2a80-cc61-43e7-8be8-fb60ef23f80e	{"action":"token_revoked","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-23 18:40:10.593965+00	
00000000-0000-0000-0000-000000000000	3b924586-4453-4825-ac93-333dddc92ab1	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 11:53:53.286553+00	
00000000-0000-0000-0000-000000000000	ebfa70a1-a74c-4bc5-9816-47a8558b2103	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 11:54:34.059021+00	
00000000-0000-0000-0000-000000000000	6de3f595-d6be-461f-be20-5a119fdfd17b	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 12:07:01.50076+00	
00000000-0000-0000-0000-000000000000	41897b27-f293-41c4-93ce-828ee8607bb1	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 12:22:39.430209+00	
00000000-0000-0000-0000-000000000000	2af4a595-aa14-4eb0-b67c-5978d1c2fd23	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 12:24:07.645768+00	
00000000-0000-0000-0000-000000000000	b19d4406-2c96-410c-bab3-6d3fb065ea7b	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 12:25:56.202959+00	
00000000-0000-0000-0000-000000000000	73de9f38-a7e0-4f52-8bc0-32c432e5cda7	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 12:26:10.58856+00	
00000000-0000-0000-0000-000000000000	71d90ac4-b73e-4fef-8eeb-3d4cfc417fc4	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 12:27:52.302075+00	
00000000-0000-0000-0000-000000000000	2b7798a1-56a5-4176-b5b8-be468473a3c2	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 12:29:02.726405+00	
00000000-0000-0000-0000-000000000000	18df4a01-d1c6-4bc1-a6e6-015bf695f7f1	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 12:29:10.572408+00	
00000000-0000-0000-0000-000000000000	34eeaf9f-143b-465e-aed5-ec42fe5a4f16	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 12:29:17.134449+00	
00000000-0000-0000-0000-000000000000	24586ff4-aaa5-461b-a042-287c55e46662	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 12:34:35.28845+00	
00000000-0000-0000-0000-000000000000	a02dbe12-fae2-4f86-a815-d9f9bfc693fb	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 12:35:15.434387+00	
00000000-0000-0000-0000-000000000000	a5a10403-3f9c-4d38-a400-a40b9298c5be	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 12:36:37.50936+00	
00000000-0000-0000-0000-000000000000	5eb5ed96-6082-408b-9e79-34007dce7826	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 12:36:42.102225+00	
00000000-0000-0000-0000-000000000000	16d72ed1-cb75-44be-99a3-2504620eb7e2	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 12:42:10.976322+00	
00000000-0000-0000-0000-000000000000	febc84c7-dec7-4ce7-8b07-0a6f38d20ae8	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:10:56.733656+00	
00000000-0000-0000-0000-000000000000	98b621cc-147d-423f-839e-80edb1b815aa	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:19:24.548963+00	
00000000-0000-0000-0000-000000000000	c10c3db7-c3b7-4e70-a1d6-0936bcc9e27d	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:19:28.039556+00	
00000000-0000-0000-0000-000000000000	1673d1ae-083b-4281-be5c-f72d1549c131	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:21:11.395005+00	
00000000-0000-0000-0000-000000000000	7d68b8d0-5c30-4fbb-b354-b54eb74df55b	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:21:15.458309+00	
00000000-0000-0000-0000-000000000000	13724dc7-b390-43d7-bdcb-bf962398992b	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:22:31.79393+00	
00000000-0000-0000-0000-000000000000	85ba41f1-32f4-44b6-83ee-348b98bba79c	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:22:50.416563+00	
00000000-0000-0000-0000-000000000000	54beec6c-f2e0-4a0f-979e-30305eb3a179	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:24:34.163073+00	
00000000-0000-0000-0000-000000000000	179378ea-a5d8-49c3-9ab1-0d48dcf0699d	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:24:59.835498+00	
00000000-0000-0000-0000-000000000000	f4f7bd05-0c06-4bda-b382-b101adfb09c6	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:26:46.797931+00	
00000000-0000-0000-0000-000000000000	02642d74-f4dd-4895-bb44-9357c27d0726	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 13:26:51.963134+00	
00000000-0000-0000-0000-000000000000	3145afd4-7447-4b51-948b-e2e711029dda	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:27:11.521797+00	
00000000-0000-0000-0000-000000000000	b46c9b00-8a55-49a1-af27-6baf112de031	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 13:29:12.376855+00	
00000000-0000-0000-0000-000000000000	f914cd3a-57e2-431e-b057-7def696e38af	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:29:17.650934+00	
00000000-0000-0000-0000-000000000000	a38a2325-8476-4f97-9605-96f354e3617a	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:29:28.295401+00	
00000000-0000-0000-0000-000000000000	2b284f13-29ee-4faa-92c3-fec90e8161fe	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:29:38.141791+00	
00000000-0000-0000-0000-000000000000	15fde815-5392-4fbe-a762-8da49ab1e3d6	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:31:03.433179+00	
00000000-0000-0000-0000-000000000000	c2ea9c1a-0243-4c4d-ae08-cda93e2d1a3e	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:31:17.379006+00	
00000000-0000-0000-0000-000000000000	e05e0d84-5a8a-416c-8f8b-1daada203393	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:32:20.702165+00	
00000000-0000-0000-0000-000000000000	8747ca44-4f20-4741-895c-054991b02e3a	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:33:13.535902+00	
00000000-0000-0000-0000-000000000000	4ee88999-ac73-4442-a921-7259b773ecee	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:34:48.866836+00	
00000000-0000-0000-0000-000000000000	1db869ce-bebe-4303-b57e-6cd603a18355	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:34:58.564227+00	
00000000-0000-0000-0000-000000000000	4c93e529-4e36-41c0-ba6d-b5099ccd8f7e	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:36:54.77838+00	
00000000-0000-0000-0000-000000000000	ffaeccd3-490e-4886-8c18-aa6ccb6f3f55	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:37:04.441259+00	
00000000-0000-0000-0000-000000000000	dd61fcf6-a122-42d3-86f2-7a1c127d6e13	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 13:37:13.580545+00	
00000000-0000-0000-0000-000000000000	4820ea30-4c16-4322-8f42-2add1cac1cc3	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:37:17.267821+00	
00000000-0000-0000-0000-000000000000	94430235-c982-49cf-bda8-302a8dc0f552	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:37:27.793109+00	
00000000-0000-0000-0000-000000000000	bf775c76-09db-4a7e-9615-6a86134c68a6	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 13:38:00.930605+00	
00000000-0000-0000-0000-000000000000	e77fecc4-cf31-41c0-bbf2-468c8d65ed76	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:38:03.839044+00	
00000000-0000-0000-0000-000000000000	1d01786e-0f36-47e4-9087-debfddcdf653	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 13:38:20.676439+00	
00000000-0000-0000-0000-000000000000	8da36002-341e-4899-a5eb-44fb95c8c869	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:38:23.113848+00	
00000000-0000-0000-0000-000000000000	591fa83a-0cfa-4643-b531-b1840fde66a8	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 13:38:41.328779+00	
00000000-0000-0000-0000-000000000000	e83010be-5070-4360-b189-867ab89e0379	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:38:44.033979+00	
00000000-0000-0000-0000-000000000000	5c3d44dd-1bd5-4289-b365-a20eb323ca46	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 13:39:39.45283+00	
00000000-0000-0000-0000-000000000000	ffd96aee-9d34-4be8-93b1-05d543f2e143	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:41:10.138784+00	
00000000-0000-0000-0000-000000000000	25dfb389-c4aa-4c44-a6fe-6c5c58dbd4c2	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:42:38.100988+00	
00000000-0000-0000-0000-000000000000	7db773c8-fbea-4ec3-96b1-a20baba051f0	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:42:45.291917+00	
00000000-0000-0000-0000-000000000000	5b42cb87-5502-480c-930f-11e87743ce44	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:42:56.920224+00	
00000000-0000-0000-0000-000000000000	f27fc5dc-a3e5-42b0-aa8e-e990dd79508a	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:43:45.148793+00	
00000000-0000-0000-0000-000000000000	beee714e-57fc-4be5-84d5-650667dc86c8	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:43:50.311079+00	
00000000-0000-0000-0000-000000000000	450b714d-a40c-4ae8-8ee9-ee8fce112a89	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:44:19.850785+00	
00000000-0000-0000-0000-000000000000	104ec138-7165-4423-9217-e4e14695d745	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:45:09.347372+00	
00000000-0000-0000-0000-000000000000	34d33848-10bb-4cba-8992-9c01ad4bf015	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:45:17.507851+00	
00000000-0000-0000-0000-000000000000	699ab09e-815c-4fd1-b8af-08f217eb2693	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 13:46:56.748202+00	
00000000-0000-0000-0000-000000000000	eb35940a-a0f3-4920-b5a1-b3bea1053bfc	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:46:58.743096+00	
00000000-0000-0000-0000-000000000000	a5916592-6a40-4e72-b5a3-df64eb9be1e1	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 13:47:04.694993+00	
00000000-0000-0000-0000-000000000000	1445d662-d497-4fc1-a9a1-6998bb7b8c8a	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:47:06.023549+00	
00000000-0000-0000-0000-000000000000	a2836a96-13e4-4c19-822f-a13da585fa5f	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 13:48:17.228005+00	
00000000-0000-0000-0000-000000000000	00d60d5a-9bff-4c05-8bc9-63cce15b8a62	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:50:07.059346+00	
00000000-0000-0000-0000-000000000000	630fb99c-8d51-4148-8c3b-299fbdce4a0a	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:51:45.381078+00	
00000000-0000-0000-0000-000000000000	cd62c35d-b90b-4ed8-9b9d-228c74f7cfed	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:51:56.288336+00	
00000000-0000-0000-0000-000000000000	88676f78-c078-461a-870d-fd691d69dcfc	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:53:57.963007+00	
00000000-0000-0000-0000-000000000000	b7da30f2-9ee9-4fa9-a21c-cd6a458559df	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:54:07.054161+00	
00000000-0000-0000-0000-000000000000	24855633-3995-44b8-b412-aa96f62383ac	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:54:18.493284+00	
00000000-0000-0000-0000-000000000000	2242ca9d-562e-43cd-b309-c907e58be929	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:55:35.350451+00	
00000000-0000-0000-0000-000000000000	c41ab8a8-52a8-404c-8517-06a8d3ab1fca	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 13:55:50.47532+00	
00000000-0000-0000-0000-000000000000	f2b59cd9-3fa2-4d09-ade2-c4843d691ed9	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:09:41.415704+00	
00000000-0000-0000-0000-000000000000	a53550a5-0551-4ead-92ba-342131c6ced2	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:09:44.621593+00	
00000000-0000-0000-0000-000000000000	b2d3f9d0-33af-453a-ba9f-c0fa4e407f6e	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:09:51.843189+00	
00000000-0000-0000-0000-000000000000	ef6b78cb-0a80-4513-be4a-fc83d854374a	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:09:56.647406+00	
00000000-0000-0000-0000-000000000000	7cacedb1-6dbd-483c-9e75-21ca566bebdc	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:10:51.411836+00	
00000000-0000-0000-0000-000000000000	e8cf19c7-af8f-4556-b355-2d51b9397e06	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:12:03.351037+00	
00000000-0000-0000-0000-000000000000	9615ce4f-3659-4bf9-9f84-54056977ba1d	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:12:13.045668+00	
00000000-0000-0000-0000-000000000000	56c32144-8c2d-479d-ad1c-150405ee77b0	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:12:15.150712+00	
00000000-0000-0000-0000-000000000000	f292e822-c5da-4ffb-8c60-ff2e599d230e	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:12:16.233725+00	
00000000-0000-0000-0000-000000000000	b4f5155b-607f-43f5-9da2-890366fee9ef	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:12:23.548702+00	
00000000-0000-0000-0000-000000000000	9a887f80-07e5-4a47-86e6-03688b29c5ae	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:12:35.54396+00	
00000000-0000-0000-0000-000000000000	fc526426-0919-4e8b-9781-6dd48ee64e07	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:13:09.757676+00	
00000000-0000-0000-0000-000000000000	cc7187f8-d790-40ef-84e7-6458771de648	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:14:33.067133+00	
00000000-0000-0000-0000-000000000000	1d68568f-865b-4427-ac91-28a6b533be34	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:15:06.636509+00	
00000000-0000-0000-0000-000000000000	0471a054-0a02-4c67-8e1b-b47b50b6a4fc	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:15:13.130188+00	
00000000-0000-0000-0000-000000000000	ee6ee782-be70-4e85-8e56-77a24442edd3	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:15:18.62456+00	
00000000-0000-0000-0000-000000000000	b6b5f612-acc6-434b-96c7-7464d6a82f4b	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:16:18.57051+00	
00000000-0000-0000-0000-000000000000	1abe6172-1b6c-4607-8c3e-9e9f7453ee20	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:16:52.091041+00	
00000000-0000-0000-0000-000000000000	590bff36-9e40-4faa-9ae1-3a83d997c714	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:18:23.731934+00	
00000000-0000-0000-0000-000000000000	cba7defe-2391-4456-985f-44daf29083e5	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:21:05.797218+00	
00000000-0000-0000-0000-000000000000	2675dd37-ec66-422b-bb01-07a8fc9c8959	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 14:21:41.745144+00	
00000000-0000-0000-0000-000000000000	e8951805-6246-46c6-b3e3-6132b0bff076	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:21:43.450156+00	
00000000-0000-0000-0000-000000000000	7a3cc668-9c66-4c83-b762-247c33c86eaf	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 14:22:30.714475+00	
00000000-0000-0000-0000-000000000000	129efbcf-bd6c-497e-9087-566b300b4d5a	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:23:08.755607+00	
00000000-0000-0000-0000-000000000000	6dc4bdcb-9a26-40b7-bcb9-153b1cad2d9f	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 14:24:05.028515+00	
00000000-0000-0000-0000-000000000000	d5dd4235-fc53-4709-bb65-abad550d8192	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:24:36.141308+00	
00000000-0000-0000-0000-000000000000	877f3ccc-6bb7-4bf4-9cf3-439d7d6653d5	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 14:25:10.559334+00	
00000000-0000-0000-0000-000000000000	9df53414-d867-4ca4-ae72-7343d5b69285	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:25:12.403644+00	
00000000-0000-0000-0000-000000000000	80003808-e95c-4378-a944-bb759257a8f6	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 14:25:14.026513+00	
00000000-0000-0000-0000-000000000000	2dc1475c-ecee-42fc-837a-baa0953fc265	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:25:15.296299+00	
00000000-0000-0000-0000-000000000000	19d89a90-be8e-4417-bc88-9029a13cccf1	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 14:25:17.316752+00	
00000000-0000-0000-0000-000000000000	d947b413-b551-4709-8ecd-0aa528e9a713	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:25:19.200116+00	
00000000-0000-0000-0000-000000000000	41c5560e-bb10-42ae-a381-8a7c87d1239f	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 14:25:30.094703+00	
00000000-0000-0000-0000-000000000000	149eef84-3978-4646-ae91-7db1ff58195e	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:25:31.626462+00	
00000000-0000-0000-0000-000000000000	02730e6e-0a50-48e5-8080-c58ed20f3059	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 14:26:52.835234+00	
00000000-0000-0000-0000-000000000000	d1bcc86a-bfae-4c14-ab3c-274f94f8f403	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:27:05.311536+00	
00000000-0000-0000-0000-000000000000	dc37ab91-c40a-497f-b114-dbbf101947b8	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 14:28:10.260741+00	
00000000-0000-0000-0000-000000000000	ee6f7823-71cc-41bf-a154-bc789bea03e4	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:28:19.132203+00	
00000000-0000-0000-0000-000000000000	78dd3d9b-2289-4c85-b1fa-46f1b3d625b7	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 14:29:24.76238+00	
00000000-0000-0000-0000-000000000000	8dc5285a-30ac-473f-bbf6-184924b2fb09	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:51:31.458823+00	
00000000-0000-0000-0000-000000000000	8fe38c1f-44be-4c71-a63c-b935d1845aad	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 14:57:45.946355+00	
00000000-0000-0000-0000-000000000000	bd36e12b-983a-42ad-9063-f86b306f2d7f	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 14:57:48.101312+00	
00000000-0000-0000-0000-000000000000	b36f744b-00cc-44e1-8d91-d274c17d1b53	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 15:00:00.498884+00	
00000000-0000-0000-0000-000000000000	d9e61e86-075e-46c0-98c3-028ac9730692	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 15:00:06.905133+00	
00000000-0000-0000-0000-000000000000	86e3651a-fec3-4142-97f4-0ee954c27d7b	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 15:00:43.042997+00	
00000000-0000-0000-0000-000000000000	42d28ec4-c712-4337-98f2-deb0ed33e859	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 15:00:56.095554+00	
00000000-0000-0000-0000-000000000000	e39f36d5-3c36-487a-9110-47d70f1e195a	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 15:04:16.735899+00	
00000000-0000-0000-0000-000000000000	a7720605-64ed-4801-a4d3-f71ef0bfd1fe	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 15:09:12.230091+00	
00000000-0000-0000-0000-000000000000	2f8eb170-4986-44d0-bc94-133e920d3658	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 15:09:41.853827+00	
00000000-0000-0000-0000-000000000000	5f013109-ba3c-4ca0-aa19-5dcb8597aa6a	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 15:12:24.576234+00	
00000000-0000-0000-0000-000000000000	4c3e1e74-d956-4e94-91d8-08f461bf904c	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 15:12:35.139041+00	
00000000-0000-0000-0000-000000000000	af091951-e218-4f70-9bb6-7166e8fb9846	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 15:13:03.861983+00	
00000000-0000-0000-0000-000000000000	8ba4a67d-c481-4c95-93ff-ee6393f490c5	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 15:13:05.144119+00	
00000000-0000-0000-0000-000000000000	3c178416-b419-4284-92af-63f6f34947af	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 15:17:30.240621+00	
00000000-0000-0000-0000-000000000000	729e42de-d35f-4450-9f85-d0e21ed5c1fc	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 15:17:44.256605+00	
00000000-0000-0000-0000-000000000000	4362de51-b148-4f7c-afb0-bf40ebd85e7f	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 15:29:29.156942+00	
00000000-0000-0000-0000-000000000000	bb474f5b-98b2-4685-80a8-52ab6fdbf26e	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 15:32:37.162253+00	
00000000-0000-0000-0000-000000000000	211e7d94-c8f0-4964-9697-59e07bdb1d90	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 15:32:38.659745+00	
00000000-0000-0000-0000-000000000000	f6cb9b99-71b9-4b09-a016-c4d708e3a950	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 15:43:37.623333+00	
00000000-0000-0000-0000-000000000000	f6072d04-c2f2-48e9-bfdc-868605e48d65	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 15:45:04.32058+00	
00000000-0000-0000-0000-000000000000	05abf586-11d8-4886-be80-4d5780bd76ac	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 15:49:05.333012+00	
00000000-0000-0000-0000-000000000000	1f52b26d-7326-456a-b790-303d33e26358	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 15:49:17.756536+00	
00000000-0000-0000-0000-000000000000	7bd36fe9-e007-4b33-916b-df7e98800f29	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 15:51:36.307891+00	
00000000-0000-0000-0000-000000000000	884f95a8-414c-4eb4-8f94-1da4353bb199	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 15:51:47.622555+00	
00000000-0000-0000-0000-000000000000	a20f469d-b870-4a42-a637-c853e7bbf743	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 15:54:50.360949+00	
00000000-0000-0000-0000-000000000000	d89682d3-1d6d-4efe-a10b-17b878f51153	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 15:55:03.740704+00	
00000000-0000-0000-0000-000000000000	814751f0-eb76-4079-bde3-404700b66047	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 15:59:22.358345+00	
00000000-0000-0000-0000-000000000000	dcbeca88-c98e-43b5-96f2-43d403a3073a	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 15:59:28.115845+00	
00000000-0000-0000-0000-000000000000	4e9849a2-d5cc-4e98-8ce5-412627b857d7	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 16:04:53.819279+00	
00000000-0000-0000-0000-000000000000	1fbc6e49-a52b-48d6-859a-1ac61d208b98	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:05:06.06644+00	
00000000-0000-0000-0000-000000000000	22765f7d-2641-46e2-bdcc-49c8e1c9d37e	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 16:10:13.091219+00	
00000000-0000-0000-0000-000000000000	0cd54b68-8d30-4f5a-8b19-14bc52cb4465	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:10:19.727753+00	
00000000-0000-0000-0000-000000000000	2dc2f384-d025-4bba-b9c9-b888f1649a1b	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 16:11:30.52443+00	
00000000-0000-0000-0000-000000000000	98a7f7e8-09d0-4a6e-a494-367059c76e20	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:11:41.774197+00	
00000000-0000-0000-0000-000000000000	f88a4be7-1dae-404f-8bfa-bbfd995822a9	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:18:52.440991+00	
00000000-0000-0000-0000-000000000000	21582232-5e86-4185-ba29-a0a1e6cb804b	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:18:55.318204+00	
00000000-0000-0000-0000-000000000000	99c25fa8-55ad-4659-961c-5fc969f1b920	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:19:16.840314+00	
00000000-0000-0000-0000-000000000000	46c93c68-f026-4d0a-b845-4d42f8470b92	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:24:33.262376+00	
00000000-0000-0000-0000-000000000000	3e87b706-2371-4319-b19d-fa6c8bea40c1	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:25:24.289947+00	
00000000-0000-0000-0000-000000000000	4c08c5d9-4358-4d85-9cb6-50926da1f17d	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 16:26:22.074129+00	
00000000-0000-0000-0000-000000000000	af4044de-c5e0-4a07-9ad5-9ab32b9007fe	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:26:23.908889+00	
00000000-0000-0000-0000-000000000000	5becf48b-04cc-4dcd-8925-28114b28d58d	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:27:18.046014+00	
00000000-0000-0000-0000-000000000000	dfa15f6a-92e0-4d55-becc-e95e2634dab2	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:27:21.726739+00	
00000000-0000-0000-0000-000000000000	4a2c6d57-27ff-4fcc-bcf8-b69ca44caf35	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:27:30.982742+00	
00000000-0000-0000-0000-000000000000	a5e8e48f-e089-4c09-8ded-00dc63f7eea4	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:28:26.344394+00	
00000000-0000-0000-0000-000000000000	4c83294b-123e-4bd9-a02d-f828407c8620	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:28:39.344619+00	
00000000-0000-0000-0000-000000000000	01567cdd-8aa1-4746-b9e2-a89b7fca1b08	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:28:52.851883+00	
00000000-0000-0000-0000-000000000000	3d33a7d5-fd7c-4c4f-8e59-84067311a98e	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:30:22.409255+00	
00000000-0000-0000-0000-000000000000	71d54383-e025-4678-8cbc-123206386077	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:30:43.671479+00	
00000000-0000-0000-0000-000000000000	a090216e-b4dd-4d4c-b80e-71d47153d46a	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:31:04.807576+00	
00000000-0000-0000-0000-000000000000	ed2c4e5a-abaa-46ac-8d11-1edfa224ce51	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 16:35:18.966157+00	
00000000-0000-0000-0000-000000000000	ef04e46c-fe09-4420-a0ba-1828e739e651	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:35:30.286198+00	
00000000-0000-0000-0000-000000000000	a5a1cf9f-0550-46f0-9dd7-205832f909fb	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:40:35.738835+00	
00000000-0000-0000-0000-000000000000	49fb7a0d-949e-4c96-87cb-6df007093f59	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 16:45:25.209894+00	
00000000-0000-0000-0000-000000000000	a5dbd86e-b9c8-4bcc-8b4e-3968aa0a4e19	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:45:32.679033+00	
00000000-0000-0000-0000-000000000000	0547e72f-a9e8-4cbb-848d-4214cd28d07c	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:47:14.967216+00	
00000000-0000-0000-0000-000000000000	6c02af84-24e0-445c-948d-fc4aef329f94	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 16:48:20.059545+00	
00000000-0000-0000-0000-000000000000	7143eb8b-4bd4-4f17-8064-77971d5cc936	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:48:24.787187+00	
00000000-0000-0000-0000-000000000000	f67e622e-be18-4b55-af91-7661a7243b95	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 16:53:00.932553+00	
00000000-0000-0000-0000-000000000000	bb62319c-d767-48cf-b3be-f62d15a7dc39	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:53:13.473135+00	
00000000-0000-0000-0000-000000000000	e8d02366-bf94-439d-92b3-38682156794a	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 16:54:15.508157+00	
00000000-0000-0000-0000-000000000000	91037204-8949-48cf-80a0-483c9a051f01	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 16:54:15.509134+00	
00000000-0000-0000-0000-000000000000	e5516b56-960f-467b-999e-9df070b505ad	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:54:31.223846+00	
00000000-0000-0000-0000-000000000000	0c75a77e-6295-42fa-8715-9eb127d281d7	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 16:55:03.015984+00	
00000000-0000-0000-0000-000000000000	18ad79c1-7322-4c90-a062-617b660c041b	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:55:27.266256+00	
00000000-0000-0000-0000-000000000000	aa60b713-e14d-4db4-838d-10b8f91bd2c0	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 16:57:20.798092+00	
00000000-0000-0000-0000-000000000000	2ce35ebb-8148-4b1f-8109-121a19eaf2a8	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 16:57:20.798716+00	
00000000-0000-0000-0000-000000000000	fc878510-250c-46cd-a2ae-1a0a9a1f0bb1	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 16:57:24.996724+00	
00000000-0000-0000-0000-000000000000	0f43dbde-389e-440b-ac4d-cd4767ac8310	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 16:57:32.878317+00	
00000000-0000-0000-0000-000000000000	b91e3abd-4e62-4fad-89d2-b4d6586070ce	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 16:57:41.051051+00	
00000000-0000-0000-0000-000000000000	f2ebe72d-6ee2-4840-a4da-df671d507cc8	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 16:57:41.051815+00	
00000000-0000-0000-0000-000000000000	360983e9-5d97-4bc2-895c-349736b563ed	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 16:57:47.619046+00	
00000000-0000-0000-0000-000000000000	72c15783-e1f9-4bf5-8385-0ccc3f24f4ab	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 16:57:47.619827+00	
00000000-0000-0000-0000-000000000000	29c75a0a-28d9-4052-934e-06da6cbdba7a	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 16:59:33.397977+00	
00000000-0000-0000-0000-000000000000	f34f1f51-d9ac-4a34-80d5-b94029211bdd	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 16:59:33.398674+00	
00000000-0000-0000-0000-000000000000	153a18d0-9c3d-49a4-a0d3-58c2c0c70f4b	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 16:59:36.162633+00	
00000000-0000-0000-0000-000000000000	0cefa408-5926-41e6-b5e0-2f304f1100ac	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 16:59:36.163267+00	
00000000-0000-0000-0000-000000000000	a382470f-60b8-4072-a1c1-139e510f0051	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 16:59:43.275203+00	
00000000-0000-0000-0000-000000000000	4ab4bcb1-409c-426b-b995-07838d0015a7	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 16:59:43.275946+00	
00000000-0000-0000-0000-000000000000	5bd48145-5411-4126-9999-0e87b0391309	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:00:13.999501+00	
00000000-0000-0000-0000-000000000000	a56654e4-a22e-40db-a233-64e0217f1b3b	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:00:14.002544+00	
00000000-0000-0000-0000-000000000000	0056eb36-ad4d-4e18-988e-28e2b43259cd	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 17:00:16.080513+00	
00000000-0000-0000-0000-000000000000	e689502d-27ec-4e75-9f06-9dfee977c587	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 17:00:21.527407+00	
00000000-0000-0000-0000-000000000000	5df50829-53fd-4ad9-a7a3-714fa68285f2	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 17:21:05.918797+00	
00000000-0000-0000-0000-000000000000	f155c59f-2ead-4699-bc7c-252a07d43519	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:21:11.67233+00	
00000000-0000-0000-0000-000000000000	0458dad9-6041-43d5-a256-74324850e249	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:21:11.672947+00	
00000000-0000-0000-0000-000000000000	d7f825c0-91fe-41ab-ae9d-6062e23c864c	{"action":"logout","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-01-24 17:30:47.51929+00	
00000000-0000-0000-0000-000000000000	4b3e7979-1aab-4e70-958e-b60d57476c8e	{"action":"login","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-01-24 17:30:49.501332+00	
00000000-0000-0000-0000-000000000000	f8e85538-2b9e-45cf-a934-6330ff23fc93	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:30:53.242349+00	
00000000-0000-0000-0000-000000000000	aa4dcefd-5a4f-406d-90cc-f0d128fce5a5	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:30:53.242969+00	
00000000-0000-0000-0000-000000000000	9b2b8c75-73d1-4198-8077-799f8f6066e7	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:30:58.601202+00	
00000000-0000-0000-0000-000000000000	e55a1b39-6427-4cf7-9d3b-3a8696b4a718	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:30:58.601961+00	
00000000-0000-0000-0000-000000000000	a90c092a-5b69-4c38-a9f2-04241b4ddb51	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:35:33.645289+00	
00000000-0000-0000-0000-000000000000	fd5a8ee4-7ece-4ee5-98eb-dbc804c7eb29	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:35:33.648683+00	
00000000-0000-0000-0000-000000000000	3ad8c8ee-d651-4dfc-ad06-9622f9f9487d	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:35:51.481503+00	
00000000-0000-0000-0000-000000000000	e0a73ffd-817d-4fe3-ab20-e623cfe8c391	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:35:51.482825+00	
00000000-0000-0000-0000-000000000000	d420ae20-7d31-44c5-ad5e-a60ca317848d	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:46:11.022265+00	
00000000-0000-0000-0000-000000000000	06d60fa2-ad3d-4fa3-9c38-635a33fe1d3c	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:46:11.023347+00	
00000000-0000-0000-0000-000000000000	25ca8b45-42eb-491b-827e-97547ebb2d15	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:46:12.836924+00	
00000000-0000-0000-0000-000000000000	e44febf6-8532-42d3-a649-e372dacff153	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:46:12.837597+00	
00000000-0000-0000-0000-000000000000	c42127a7-777b-465e-aebd-d93e8375fce8	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:59:32.751104+00	
00000000-0000-0000-0000-000000000000	1150ef53-6291-4b63-8023-0f93c6a48c1e	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 17:59:32.753175+00	
00000000-0000-0000-0000-000000000000	17e29870-94f0-471e-a51e-73693a2cc02d	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:00:37.03039+00	
00000000-0000-0000-0000-000000000000	30ea0102-9e85-45bc-8deb-5c4258998a2c	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:00:37.032212+00	
00000000-0000-0000-0000-000000000000	b41cf406-de52-4c1b-951d-9866cc5b4194	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:00:41.762623+00	
00000000-0000-0000-0000-000000000000	74bf8564-da62-499e-9d51-3362f8ca87e8	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:00:41.765051+00	
00000000-0000-0000-0000-000000000000	e894d0dc-a0d2-4e94-afd4-95f2e70159ea	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:00:46.153971+00	
00000000-0000-0000-0000-000000000000	3e7a5b84-bb6b-4eea-939c-3f1703b54f43	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:00:46.154573+00	
00000000-0000-0000-0000-000000000000	50a97a1a-7d81-4efa-aeda-ea16566e4acc	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:00:57.821379+00	
00000000-0000-0000-0000-000000000000	3aaac58e-2a40-48c1-80ab-86a8c79e8a45	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:00:57.82202+00	
00000000-0000-0000-0000-000000000000	6fdf0d47-63cb-4396-9b0f-7c22bc75f691	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:01:03.131189+00	
00000000-0000-0000-0000-000000000000	bc977de5-6d21-4826-adb5-b14c9c49fb7d	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:01:03.131814+00	
00000000-0000-0000-0000-000000000000	57629162-8821-4de3-b507-7e018d454a0b	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:01:07.181436+00	
00000000-0000-0000-0000-000000000000	01f5de02-f220-4f77-acee-cf5d72bf403c	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:01:07.182222+00	
00000000-0000-0000-0000-000000000000	51d17b01-0aa6-48cd-8a8d-ce77bbdcd73f	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:01:50.135458+00	
00000000-0000-0000-0000-000000000000	ec02db86-5fa0-49f8-9cf7-ac128f5aa127	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:01:50.136126+00	
00000000-0000-0000-0000-000000000000	49dde207-5ab0-4d1d-85b4-774c6d0f3158	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:01:59.403735+00	
00000000-0000-0000-0000-000000000000	f13744b1-97ed-4879-9b02-d110cf26ced8	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:01:59.404369+00	
00000000-0000-0000-0000-000000000000	f965a52d-30d8-46c8-935b-7703f02ee47e	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:02:04.860416+00	
00000000-0000-0000-0000-000000000000	b133112a-d7d5-4729-8893-089c5b0824cc	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:02:04.86111+00	
00000000-0000-0000-0000-000000000000	fb673f6a-bad0-40a3-a307-7ac55b473f68	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:02:14.495235+00	
00000000-0000-0000-0000-000000000000	149195a5-b0d9-41cc-befe-4e44b526ebec	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:02:14.495851+00	
00000000-0000-0000-0000-000000000000	864b086c-d71d-4caa-8c36-121eb27a2ca5	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:02:26.024892+00	
00000000-0000-0000-0000-000000000000	2f573eb5-bef1-4b88-8c21-44b4d345059b	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:02:26.025662+00	
00000000-0000-0000-0000-000000000000	836abeea-6218-4cdb-84c3-43ac9a30975b	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:02:46.450111+00	
00000000-0000-0000-0000-000000000000	d66b1bce-86f5-409c-a25d-da752229bd1d	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:02:46.450728+00	
00000000-0000-0000-0000-000000000000	517af2d2-50ed-4d19-bf19-f2caf45fd75d	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:02:51.782862+00	
00000000-0000-0000-0000-000000000000	7828dc47-3802-4909-bb3f-d492c1b36cea	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:02:51.783559+00	
00000000-0000-0000-0000-000000000000	91135d79-96be-42d1-b024-ac9d20830a7a	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:03:02.83755+00	
00000000-0000-0000-0000-000000000000	80d40d45-5027-4e5b-b78c-563ae6f4e7fc	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:03:02.838236+00	
00000000-0000-0000-0000-000000000000	b02c16d3-d508-466d-bacd-e604ce29ec2b	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:03:10.784428+00	
00000000-0000-0000-0000-000000000000	9b39c928-31a9-4f2f-8f17-16a1b96e0762	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:03:10.785073+00	
00000000-0000-0000-0000-000000000000	65070336-b025-497d-b3a2-9721e99dcdb7	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:03:15.122438+00	
00000000-0000-0000-0000-000000000000	1aff04b0-4d42-4491-831e-3d821d96f6af	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:03:15.123117+00	
00000000-0000-0000-0000-000000000000	e8e6acce-7f84-4beb-a6e5-0a97d3bb84fd	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:03:43.739494+00	
00000000-0000-0000-0000-000000000000	f1808bf5-769d-44c0-885a-f3749fca1d07	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:03:43.740172+00	
00000000-0000-0000-0000-000000000000	f3cc36d2-effa-4cf8-bb9e-9797031772e3	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:03:49.304091+00	
00000000-0000-0000-0000-000000000000	fbeb67f4-e6f2-4798-8618-091e3cf2de20	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:03:49.304739+00	
00000000-0000-0000-0000-000000000000	dc355c2d-2b0e-452b-8536-8a155e5b9cdc	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:03:53.65537+00	
00000000-0000-0000-0000-000000000000	194dc704-7b04-4c80-95f3-57f4bbd03faa	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:03:53.655995+00	
00000000-0000-0000-0000-000000000000	a4f81bf1-8da2-4479-b0a0-2c34e66b62fa	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:04:06.63833+00	
00000000-0000-0000-0000-000000000000	647d7244-f181-4fa5-91fa-b966ae67e0b6	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:04:06.639051+00	
00000000-0000-0000-0000-000000000000	a941b433-c6b7-4e26-b5ed-19a77a67a508	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:04:13.206246+00	
00000000-0000-0000-0000-000000000000	7d1e690f-6cca-4b49-95a8-3926a8912e43	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:04:13.206937+00	
00000000-0000-0000-0000-000000000000	0e0cd618-c9b8-4623-84e3-c07b8c7fa6a2	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:04:23.029174+00	
00000000-0000-0000-0000-000000000000	73c9c5a0-fe0d-466a-ad5b-379d42f8a61e	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:04:23.029891+00	
00000000-0000-0000-0000-000000000000	2e401f2e-24d0-4605-9f59-9ca497b37013	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:04:32.651512+00	
00000000-0000-0000-0000-000000000000	a9545a23-653f-4ce0-9561-fe85a0e18786	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:04:32.652175+00	
00000000-0000-0000-0000-000000000000	056636c1-9b66-4ca3-bb2c-052e61d29834	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:04:35.862763+00	
00000000-0000-0000-0000-000000000000	52909aa1-7174-4291-9631-480af65120e7	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:04:35.863512+00	
00000000-0000-0000-0000-000000000000	669080fa-2492-4e54-b4e9-8c7d0a32109e	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:04:39.811549+00	
00000000-0000-0000-0000-000000000000	cb9352d1-c119-4824-a755-b50bb0208716	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:04:39.812209+00	
00000000-0000-0000-0000-000000000000	379734b2-ede9-49ad-8770-e1eee0d3b7e6	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:04:49.151974+00	
00000000-0000-0000-0000-000000000000	c1b1de86-60ed-43fe-8b3e-77a6f4510bf2	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:04:49.152635+00	
00000000-0000-0000-0000-000000000000	22b97a50-2298-4b60-9b69-12b9dda6a4a7	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:04:58.373916+00	
00000000-0000-0000-0000-000000000000	02b1a1c0-690a-4a44-ad43-53b7f4e2cca5	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:04:58.374594+00	
00000000-0000-0000-0000-000000000000	27ae1a6e-6305-4b8f-bd6a-19b669c1b49b	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:05:17.792941+00	
00000000-0000-0000-0000-000000000000	70a25397-c041-42ad-957a-d1f3e9c3cd93	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:05:17.793653+00	
00000000-0000-0000-0000-000000000000	7e4ee8b3-f517-4486-8173-179f9bfc6635	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:05:19.750923+00	
00000000-0000-0000-0000-000000000000	a9b8d1a2-8003-448d-9e45-286ada4f61b2	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:05:19.751624+00	
00000000-0000-0000-0000-000000000000	4f2eac02-daf6-442a-a23e-e3677f591248	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:05:28.345106+00	
00000000-0000-0000-0000-000000000000	52b3725d-d542-402f-907d-99e6c2a3f3d2	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:05:28.345794+00	
00000000-0000-0000-0000-000000000000	65d392ff-8c36-4c3d-9de3-304a24a58c5d	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:05:34.801983+00	
00000000-0000-0000-0000-000000000000	805038b7-6c46-4927-b170-8482e0b15b06	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:05:34.802717+00	
00000000-0000-0000-0000-000000000000	a0124af1-b96b-4233-afcb-84d194f7950d	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:05:39.21654+00	
00000000-0000-0000-0000-000000000000	5fa29581-5fac-4124-80d5-fd321163bcae	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:05:39.217203+00	
00000000-0000-0000-0000-000000000000	dfd5c74b-a5f8-4e22-a9e0-2c3606a21cf0	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:05:42.978517+00	
00000000-0000-0000-0000-000000000000	a59a76d9-723c-4d2c-85bb-814a7550ac14	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:05:42.979233+00	
00000000-0000-0000-0000-000000000000	4699073e-25ba-4232-b35e-406bc1c4bbd7	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:05:51.712974+00	
00000000-0000-0000-0000-000000000000	78629e0c-c3a4-4238-bc24-8e5030462823	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:05:51.713645+00	
00000000-0000-0000-0000-000000000000	45486e28-e7ea-4f73-b5e9-8a8003380e5c	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:05:59.5826+00	
00000000-0000-0000-0000-000000000000	cbe8ac80-3e3b-4120-be20-cb47daf8e9d7	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:05:59.583244+00	
00000000-0000-0000-0000-000000000000	2b5ddd1b-ea16-4382-9a0d-d596e982e0e5	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:06:08.620002+00	
00000000-0000-0000-0000-000000000000	668da7fe-f015-4ee9-9a68-042d3081d33f	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:06:08.620638+00	
00000000-0000-0000-0000-000000000000	b74964b6-14f0-4404-b102-a9f0955578bc	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:06:12.409238+00	
00000000-0000-0000-0000-000000000000	e2fcaf9f-ed99-4413-8106-2d31e44c60fe	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:06:12.409874+00	
00000000-0000-0000-0000-000000000000	b789a441-36cd-45fe-8784-50ba2633b1b4	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:06:16.665433+00	
00000000-0000-0000-0000-000000000000	2040d93f-82cc-4166-9bd5-275f0aac3330	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:06:16.666084+00	
00000000-0000-0000-0000-000000000000	83927dcb-bf97-4d10-8bd1-b5e3f9ab2053	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:06:29.38464+00	
00000000-0000-0000-0000-000000000000	34cd0be6-f92e-4076-8cb9-781900bf428a	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:06:29.38545+00	
00000000-0000-0000-0000-000000000000	941f9dbc-33ba-429b-931d-508254f5f109	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:06:32.299507+00	
00000000-0000-0000-0000-000000000000	cf0f9aa5-2aac-4dc8-90f1-f8b562797c59	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:06:32.30021+00	
00000000-0000-0000-0000-000000000000	59ad30c5-16e3-4942-aea6-31c4c0658d1d	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:07:16.740501+00	
00000000-0000-0000-0000-000000000000	d15bd06e-ef8e-4d35-b2cd-f64263418b80	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:07:16.741138+00	
00000000-0000-0000-0000-000000000000	b779c12a-e0fc-4958-a65f-435543efdaf1	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:07:22.32154+00	
00000000-0000-0000-0000-000000000000	6a541b04-0a03-4771-9736-40c083cf1d63	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:07:22.322191+00	
00000000-0000-0000-0000-000000000000	b385dfea-2e7a-45df-b569-54cd5e5464c3	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:07:24.921387+00	
00000000-0000-0000-0000-000000000000	b42ca1d5-901e-4503-8433-ff049aefdf1f	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:07:24.922089+00	
00000000-0000-0000-0000-000000000000	9a6b89a5-583e-4176-82c8-7e10c76588c0	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:07:25.985846+00	
00000000-0000-0000-0000-000000000000	5851be0c-a407-443b-a05a-d2c9d7ad2a49	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:07:25.986524+00	
00000000-0000-0000-0000-000000000000	b56307b1-c1ac-4796-88f9-1586f2e5fec6	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:07:57.808858+00	
00000000-0000-0000-0000-000000000000	d693b76e-f16f-449e-a438-5ca74694189d	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:07:57.809527+00	
00000000-0000-0000-0000-000000000000	fd20a5ac-7f48-480c-8f8e-13ba9a1f952b	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:08:05.817499+00	
00000000-0000-0000-0000-000000000000	56d8f6c4-bf12-40e3-96b9-4d9918235025	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:08:05.81817+00	
00000000-0000-0000-0000-000000000000	03e83050-5b04-4994-a940-da2525825666	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:08:12.749867+00	
00000000-0000-0000-0000-000000000000	e76d85e6-c822-4d2c-8cbc-7d64ac14bf84	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:08:12.750577+00	
00000000-0000-0000-0000-000000000000	4acb8238-0003-46f9-94f7-8cfb973b41b4	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:08:31.612556+00	
00000000-0000-0000-0000-000000000000	88c4b3c8-f04e-438d-8ff7-1c4672d5900d	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:08:31.613302+00	
00000000-0000-0000-0000-000000000000	ed4981c2-2476-42d7-a66a-7346e9100e6d	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:09:07.986488+00	
00000000-0000-0000-0000-000000000000	b1e2ce60-663f-4826-8957-e3cc0999c6de	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:09:07.987256+00	
00000000-0000-0000-0000-000000000000	ecf4b111-5a02-4af6-bb0d-fbd5196c94be	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:09:08.879733+00	
00000000-0000-0000-0000-000000000000	45969124-b015-4678-aa03-67b4e40c2ef2	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:09:08.880512+00	
00000000-0000-0000-0000-000000000000	70e32992-4b0e-4ff9-8416-474cdbced593	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:09:32.805011+00	
00000000-0000-0000-0000-000000000000	e16cd36c-072f-45d0-86c3-afd48d4a5f64	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:09:32.805693+00	
00000000-0000-0000-0000-000000000000	5980aade-8db7-43f8-875d-110c7624c95d	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:10:23.078342+00	
00000000-0000-0000-0000-000000000000	986a0439-a829-4830-98c3-8079e1f51617	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:10:23.079025+00	
00000000-0000-0000-0000-000000000000	0266cd1e-21e5-4502-9765-25f5eba3e41c	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:10:33.052739+00	
00000000-0000-0000-0000-000000000000	ddbfbacf-d70b-44c9-957a-16da5de57d27	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:10:33.053525+00	
00000000-0000-0000-0000-000000000000	acd246a6-1de5-4c89-b404-2f396e03b8b8	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:11:27.447121+00	
00000000-0000-0000-0000-000000000000	f812fdf3-f601-45fc-be85-0132f7ff9d21	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:11:27.448089+00	
00000000-0000-0000-0000-000000000000	c5566afe-7bc3-4056-8397-3b65b8c7e76a	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:11:46.074686+00	
00000000-0000-0000-0000-000000000000	d9138f09-a63b-4d57-a8bb-c3addb5c902a	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:11:46.075336+00	
00000000-0000-0000-0000-000000000000	aaed8de4-f23e-483b-9395-a1868ca89e1b	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:11:51.627481+00	
00000000-0000-0000-0000-000000000000	ffbfe6c2-5229-4f7e-9047-d388913ca0b7	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:11:51.628095+00	
00000000-0000-0000-0000-000000000000	5a10d729-72b8-4ebd-98c7-34b43a9458c8	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:11:52.949879+00	
00000000-0000-0000-0000-000000000000	936bf9f1-d91b-461a-8d43-d0e6676b3299	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:11:52.950546+00	
00000000-0000-0000-0000-000000000000	39c0c290-d30b-411e-a73f-976147c04e37	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:11:54.666054+00	
00000000-0000-0000-0000-000000000000	915558ef-2139-4288-81aa-a85eca621106	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:11:54.666712+00	
00000000-0000-0000-0000-000000000000	6c45fa86-ed43-4bf9-9402-278cbe883cdd	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:12:00.379878+00	
00000000-0000-0000-0000-000000000000	943001ce-4bc9-4b10-a5f1-9eddeba0bb78	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:12:00.380803+00	
00000000-0000-0000-0000-000000000000	5ed2c579-ed5d-4629-ba0e-dc47959bde11	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:12:02.202157+00	
00000000-0000-0000-0000-000000000000	aa692ed2-0420-46a3-ba23-5f5ebbe6319b	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:12:02.202839+00	
00000000-0000-0000-0000-000000000000	82da3254-04ef-4e9f-bee4-40575289964b	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:15:00.461117+00	
00000000-0000-0000-0000-000000000000	3e56aa27-ce71-4911-84c0-87a78bc1384e	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:15:00.465784+00	
00000000-0000-0000-0000-000000000000	1990fc4c-e127-4835-b3d3-ffb3ef45954a	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:15:03.120286+00	
00000000-0000-0000-0000-000000000000	47a757a0-b309-46ab-b55e-c63c38c7a544	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:15:03.121021+00	
00000000-0000-0000-0000-000000000000	913bf7cc-397c-4c08-8d67-4503f325f9e1	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:16:55.665487+00	
00000000-0000-0000-0000-000000000000	6f4254bb-6bd6-48c5-9db4-1e2b6807dd71	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:16:55.666587+00	
00000000-0000-0000-0000-000000000000	8a6db36d-c973-4781-bc00-4d3d669beb4b	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:16:58.2592+00	
00000000-0000-0000-0000-000000000000	78965fda-aa3b-4cc9-b354-6abdd0b55b49	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:16:58.259919+00	
00000000-0000-0000-0000-000000000000	3c926f57-b8b4-49c0-b7b1-aac6bb617a4a	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:16:59.240213+00	
00000000-0000-0000-0000-000000000000	9baa74e2-03c8-4e04-8588-ddb36d94a4f0	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:16:59.240827+00	
00000000-0000-0000-0000-000000000000	cf0942a3-9171-41dd-b962-fc088ba800e2	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:17:00.170531+00	
00000000-0000-0000-0000-000000000000	f228d897-580b-4009-84fa-655ee66eaadb	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:17:00.173006+00	
00000000-0000-0000-0000-000000000000	a336b822-280b-4e21-9526-55f9e13f0ee1	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:23:44.174458+00	
00000000-0000-0000-0000-000000000000	cee3f026-f3ff-45cb-8448-c17b5882c51d	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:23:44.175381+00	
00000000-0000-0000-0000-000000000000	2cfb23f1-ebc0-491c-b90d-e62049f01902	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:32:41.850367+00	
00000000-0000-0000-0000-000000000000	8b60d949-7438-4907-806a-ff094e7de6a9	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:32:41.851339+00	
00000000-0000-0000-0000-000000000000	5b86464d-5024-41bc-bebc-9f6223067df0	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:32:44.728371+00	
00000000-0000-0000-0000-000000000000	702c36ae-40cc-461e-b423-da74f9abedfa	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:32:44.729029+00	
00000000-0000-0000-0000-000000000000	03d1e300-95e5-4e68-ade6-a0444f670039	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:32:46.29649+00	
00000000-0000-0000-0000-000000000000	6657ec87-dfcb-47d9-9b67-435792660986	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:32:46.297144+00	
00000000-0000-0000-0000-000000000000	808b83b1-836d-4f96-a31b-da5875564942	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:33:46.156609+00	
00000000-0000-0000-0000-000000000000	0cadf9e0-4286-4990-8b43-c87ab0f79340	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:33:46.157275+00	
00000000-0000-0000-0000-000000000000	dae7c283-bdb5-4b8f-9248-5f26c9a6bf22	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:33:46.99461+00	
00000000-0000-0000-0000-000000000000	d2528091-e88e-4c18-8c87-5e0e684cd931	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:33:46.995274+00	
00000000-0000-0000-0000-000000000000	859e1341-d887-4ef8-b8fd-4b542ab2edb0	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:33:48.019949+00	
00000000-0000-0000-0000-000000000000	bdf5a927-ab85-48da-beb0-f0d2ec592256	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:33:48.020771+00	
00000000-0000-0000-0000-000000000000	3c5bc8eb-d937-4e58-972f-2418aec44a48	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:33:56.031198+00	
00000000-0000-0000-0000-000000000000	e1007dd5-b764-4080-ac76-1f8392bfc8a2	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:33:56.031885+00	
00000000-0000-0000-0000-000000000000	bfcc1368-f17d-4212-96ed-a247a8e02294	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:33:58.790801+00	
00000000-0000-0000-0000-000000000000	d315c1a1-4adc-4193-bb35-cabf1f35d1ce	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:33:58.791464+00	
00000000-0000-0000-0000-000000000000	db6c6cb0-c783-4793-8cd3-10d946eb0b1e	{"action":"token_refreshed","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:36:27.686934+00	
00000000-0000-0000-0000-000000000000	00342a7a-f0ae-41b2-ac2a-1644ba28ce8c	{"action":"token_revoked","actor_id":"2eb0f80e-20cb-48ba-900a-32c311d9dfcf","actor_username":"serenyxproduction@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-01-24 18:36:27.688642+00	
00000000-0000-0000-0000-000000000000	04da4eb9-31e9-462a-b080-ea7f4d5e7280	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"discord"}}	2025-01-26 18:02:12.025938+00	
00000000-0000-0000-0000-000000000000	2d2abe42-09e5-4a5a-8cae-a537270a774c	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"discord"}}	2025-01-26 19:22:23.882919+00	
00000000-0000-0000-0000-000000000000	97381a14-a8d5-446f-bd18-c9bc55910d64	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"discord"}}	2025-01-26 19:24:40.48974+00	
00000000-0000-0000-0000-000000000000	2730d295-9d83-4669-b1e1-51d96ab204d3	{"action":"login","actor_id":"e7f95b31-2380-4d45-8692-43f9f37743ce","actor_name":"tomlit","actor_username":"tomlit@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"discord"}}	2025-01-26 19:24:59.147085+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."flow_state" ("id", "user_id", "auth_code", "code_challenge_method", "code_challenge", "provider_type", "provider_access_token", "provider_refresh_token", "created_at", "updated_at", "authentication_method", "auth_code_issued_at") FROM stdin;
bd5a501a-5da0-41c3-bf48-ea728b72ca80	e7f95b31-2380-4d45-8692-43f9f37743ce	5fef93d7-c212-47dc-b674-2c52ee3779fe	s256	feoJPuB4Qq6L9fp6FBQ7eMdG1SvLwchX1H2FCcjZiXI	discord	lK6OMSG758utJGZKHBKdVqWhlrNIRp	anZolOhRt0yAe2WEnEbIfCnjnRX09B	2025-01-26 18:02:06.040264+00	2025-01-26 18:02:12.034737+00	oauth	2025-01-26 18:02:12.034678+00
3649ba3a-f55d-4544-96fc-e6ead0133db8	e7f95b31-2380-4d45-8692-43f9f37743ce	5c571ea2-4dbd-4b20-8b56-ab3329bb0271	s256	MX0mqSPtO_7zD4WTgM1pSPHsLC2r38EX7CwADc5vP2k	discord	pOJB1EQywow3f4aBYFaLlkH6ReB3O8	PPSNTrL5bNgt6BgH04u9EraHSXFr1c	2025-01-26 19:22:12.526708+00	2025-01-26 19:22:23.886808+00	oauth	2025-01-26 19:22:23.886742+00
c492d316-c308-482e-bbd6-f1b50ed6fc37	e7f95b31-2380-4d45-8692-43f9f37743ce	7e2ae049-11ab-49e7-80ef-a164229e5567	s256	QlUoOs1nF1qONyk_Z-nraEfSXr3VlPPG6L_eehU1Zic	discord	afKz97eCuIBV3Oj7AnapSbTe8Y4BRa	5y41ONbjJvpRBNjM4zdr2gfEvziQ5x	2025-01-26 19:24:36.604718+00	2025-01-26 19:24:40.491813+00	oauth	2025-01-26 19:24:40.491763+00
70d554b8-5f33-460d-b78a-f1769e451fef	e7f95b31-2380-4d45-8692-43f9f37743ce	31a85c52-6bed-45ee-8878-a135391521ec	s256	56vWJk7Bz6M-m0k5nvK0rbZzdGtMVawnUNqqunaQg70	discord	6BNIv88PmQ3NkTRuSzarxvYud6vbpE	o2gllg1ZcXxOtgIfyvl9ABqED2OzT7	2025-01-26 19:24:55.643202+00	2025-01-26 19:24:59.147662+00	oauth	2025-01-26 19:24:59.147615+00
79298b2d-a11e-40a3-87e9-2996d56b541d	\N	107a33b3-e806-4931-bb79-1df47519b09e	s256	56vWJk7Bz6M-m0k5nvK0rbZzdGtMVawnUNqqunaQg70	discord			2025-01-26 19:25:10.93487+00	2025-01-26 19:25:10.93487+00	oauth	\N
\.


--
-- Data for Name: hooks; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY "auth"."hooks" ("id", "event", "function_name", "created_at") FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") FROM stdin;
2eb0f80e-20cb-48ba-900a-32c311d9dfcf	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	{"sub": "2eb0f80e-20cb-48ba-900a-32c311d9dfcf", "email": "serenyxproduction@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-01-21 20:41:34.797844+00	2025-01-21 20:41:34.797902+00	2025-01-21 20:41:34.797902+00	5135522e-acf5-4e71-baaa-354263e924a1
e7f95b31-2380-4d45-8692-43f9f37743ce	e7f95b31-2380-4d45-8692-43f9f37743ce	{"sub": "e7f95b31-2380-4d45-8692-43f9f37743ce", "email": "tomlit@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-01-21 23:48:43.337882+00	2025-01-21 23:48:43.337934+00	2025-01-21 23:48:43.337934+00	ff37b22c-1301-4fdb-b5e9-e128ab7f0efb
16bfe819-65d8-4e79-a96c-9b82765bd239	16bfe819-65d8-4e79-a96c-9b82765bd239	{"sub": "16bfe819-65d8-4e79-a96c-9b82765bd239", "email": "joenilan@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-01-22 00:02:58.67727+00	2025-01-22 00:02:58.67732+00	2025-01-22 00:02:58.67732+00	51e0229d-aada-4736-b61a-b3202b66d67d
5e439340-f634-4871-bdc0-1fd7748ec3c9	5e439340-f634-4871-bdc0-1fd7748ec3c9	{"sub": "5e439340-f634-4871-bdc0-1fd7748ec3c9", "email": "gaytan2012@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-01-22 00:38:39.310735+00	2025-01-22 00:38:39.310803+00	2025-01-22 00:38:39.310803+00	f01f3a31-dd4d-486c-92d0-a858c6f211af
f3fbf22b-ce0f-4af9-85a2-ea2f88a9cb85	f3fbf22b-ce0f-4af9-85a2-ea2f88a9cb85	{"sub": "f3fbf22b-ce0f-4af9-85a2-ea2f88a9cb85", "email": "nickolasheisler@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-01-22 11:48:26.325829+00	2025-01-22 11:48:26.325886+00	2025-01-22 11:48:26.325886+00	69e9bcae-f2e8-4b15-8574-ffe882b2fe5e
168922384357785600	e7f95b31-2380-4d45-8692-43f9f37743ce	{"iss": "https://discord.com/api", "sub": "168922384357785600", "name": "tomlit#0", "email": "tomlit@gmail.com", "picture": "https://cdn.discordapp.com/avatars/168922384357785600/26c24efb5e7aa53a294bd1f700af3b7d.png", "full_name": "tomlit", "avatar_url": "https://cdn.discordapp.com/avatars/168922384357785600/26c24efb5e7aa53a294bd1f700af3b7d.png", "provider_id": "168922384357785600", "custom_claims": {"global_name": "tomlit"}, "email_verified": true, "phone_verified": false}	discord	2025-01-23 07:54:37.730958+00	2025-01-23 07:54:37.731007+00	2025-01-26 19:24:59.145456+00	2e28e3ee-dfe5-4d52-98ea-92f80e90f35e
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."instances" ("id", "uuid", "raw_base_config", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") FROM stdin;
13f6aad8-cbd4-403e-b2da-16ea8674fc86	2025-01-22 02:34:08.452911+00	2025-01-22 02:34:08.452911+00	password	a4000324-10cf-45b7-93ed-ce25e213d51a
d4803839-a798-4166-a39f-e5aefb615a1a	2025-01-22 02:45:33.959349+00	2025-01-22 02:45:33.959349+00	password	0a133fa2-b737-438f-bd52-34c4b127d5ae
d02e862a-b66e-4e59-a94d-0fca43d82b7a	2025-01-22 02:46:29.389953+00	2025-01-22 02:46:29.389953+00	password	69a7d32d-2bb5-4db6-a754-af82513dd721
3f25d7e7-5e79-4691-bba3-03952e2d6201	2025-01-22 03:05:10.153685+00	2025-01-22 03:05:10.153685+00	password	60cb352f-9d7e-4347-8ad7-e96c09df4c24
d6ad9869-d16e-4e90-87fa-a307ebabeb61	2025-01-22 06:22:03.510168+00	2025-01-22 06:22:03.510168+00	password	8752c4cb-bbdf-4d19-9927-c0232ecf3ccb
3848a159-2473-41d3-b692-720bf558edf3	2025-01-22 06:33:55.919171+00	2025-01-22 06:33:55.919171+00	password	14f3c403-6a64-4d37-a809-3ce8a73e1e16
bae7c4d2-e583-4f10-ab89-422dcd0625d6	2025-01-22 11:48:44.790592+00	2025-01-22 11:48:44.790592+00	otp	02d6aabe-f2ec-4ab2-800a-e449037621f0
31e6c924-dd25-490c-9a34-f6bdb1fb074b	2025-01-22 11:48:51.376189+00	2025-01-22 11:48:51.376189+00	password	3b63c7b7-74fc-464f-a5cd-af87a3fc0ae8
75076f23-d234-4c5b-8d00-ac067a566fde	2025-01-23 07:54:37.769568+00	2025-01-23 07:54:37.769568+00	oauth	a9c5393a-49ad-4cff-9bf2-7231a8b8fad4
0605a1a5-b792-4042-b173-9e05fbe85c33	2025-01-23 08:02:13.272433+00	2025-01-23 08:02:13.272433+00	oauth	898ea41f-8ebe-48ad-8eda-c51a0bb4264a
c3564852-acf8-4ab1-8078-184a0a14e717	2025-01-23 08:08:09.122216+00	2025-01-23 08:08:09.122216+00	oauth	fbd2c7f8-7ef2-4a86-859b-a89bf795f305
2004218b-88d3-4986-b125-13f74cc51383	2025-01-23 08:10:19.800519+00	2025-01-23 08:10:19.800519+00	oauth	f147e39a-d38d-4378-9e9c-ac1496867eb2
a7830c60-0cac-4f77-a162-ed4b6bcd742c	2025-01-23 08:17:11.264428+00	2025-01-23 08:17:11.264428+00	oauth	cb2f7d04-10c2-4090-8ac4-0cfc4694ed8e
d45af473-5978-4b56-94b0-4b844da0f629	2025-01-23 08:19:16.118735+00	2025-01-23 08:19:16.118735+00	oauth	4b5bb4d8-cec0-4022-b415-fb144273cc80
164b86ee-283b-46bf-9f31-64ef4e4af8a5	2025-01-23 08:29:17.335621+00	2025-01-23 08:29:17.335621+00	oauth	fb4c3cfa-378e-406b-8586-022cfd79e35e
106277dd-dea0-446c-84d8-6251b2e5a2ec	2025-01-23 08:29:59.48647+00	2025-01-23 08:29:59.48647+00	oauth	72501cdd-70d5-4cb9-8679-777655de751a
5741ec44-2011-4f0a-a418-83b3512f1b1b	2025-01-23 08:32:16.91757+00	2025-01-23 08:32:16.91757+00	oauth	da20f6be-fe3a-472f-b983-a50862c3d3de
8ad96a0b-b207-4fe9-a94b-f81a26c03464	2025-01-22 00:38:52.152433+00	2025-01-22 00:38:52.152433+00	otp	67348d54-3fa8-468b-8274-2425b6c91686
fb0b89bc-33c4-4653-99ac-7120e59c8957	2025-01-22 00:39:01.146345+00	2025-01-22 00:39:01.146345+00	password	76620e90-ad8c-4c7b-bbe4-316ea7ce6729
a734c9f0-2e7c-477a-b8e3-138eef8160b0	2025-01-22 01:05:31.6729+00	2025-01-22 01:05:31.6729+00	password	22e2b5b8-e1da-4422-b1b0-6c43a466b4bd
94c2925d-d4a3-4fb2-815b-a267e565fd40	2025-01-22 01:32:57.183826+00	2025-01-22 01:32:57.183826+00	password	bf1576d5-ca35-4303-9aff-69db95120ed5
c57e8032-4b13-4203-988b-b9d3329411d5	2025-01-23 08:32:56.267659+00	2025-01-23 08:32:56.267659+00	oauth	e89b4d56-7024-4030-8ed2-27a05aad276e
d35d254a-6fae-4cad-8f4b-ed806e07c01a	2025-01-23 09:21:13.224894+00	2025-01-23 09:21:13.224894+00	oauth	d4f94375-feb3-4f72-82cb-9b9503ed85d8
b35bcf4d-c6fe-43b4-a098-0aabe4eac8e2	2025-01-23 09:48:05.959943+00	2025-01-23 09:48:05.959943+00	oauth	a25a898e-66fe-4f8f-87d6-e5d1961a6e03
ae84abd7-270f-42dc-a89d-8c9d29614eb8	2025-01-24 17:30:49.507181+00	2025-01-24 17:30:49.507181+00	password	a0c0b3bc-08dd-4239-9c4c-bc7a37dc9489
eb875597-6a9a-4da1-b496-608a88a28bf2	2025-01-23 15:04:04.897149+00	2025-01-23 15:04:04.897149+00	password	0e6ecd10-ebd0-4d9b-8faa-80da7c810163
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_challenges" ("id", "factor_id", "created_at", "verified_at", "ip_address", "otp_code", "web_authn_session_data") FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_factors" ("id", "user_id", "friendly_name", "factor_type", "status", "created_at", "updated_at", "secret", "phone", "last_challenged_at", "web_authn_credential", "web_authn_aaguid") FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."one_time_tokens" ("id", "user_id", "token_type", "token_hash", "relates_to", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") FROM stdin;
00000000-0000-0000-0000-000000000000	436	zHvM4E5AlRqIzOgQzODkag	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:07:16.742015+00	2025-01-24 18:07:22.322686+00	uJEs0en-UP-sBKZxRp47Eg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	437	nJayJjTz6g48hcDmO93ZwQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:07:22.322965+00	2025-01-24 18:07:24.922707+00	zHvM4E5AlRqIzOgQzODkag	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	438	3uSJuIUv-zekgwEYKFrcVw	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:07:24.923022+00	2025-01-24 18:07:25.987032+00	nJayJjTz6g48hcDmO93ZwQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	141	E0E-E9XQdb6gGLuAPvHYEw	5e439340-f634-4871-bdc0-1fd7748ec3c9	f	2025-01-22 02:45:33.957082+00	2025-01-22 02:45:33.957082+00	\N	d4803839-a798-4166-a39f-e5aefb615a1a
00000000-0000-0000-0000-000000000000	142	fsj73-RGw2cL0KCF5he7jg	5e439340-f634-4871-bdc0-1fd7748ec3c9	f	2025-01-22 02:46:29.388746+00	2025-01-22 02:46:29.388746+00	\N	d02e862a-b66e-4e59-a94d-0fca43d82b7a
00000000-0000-0000-0000-000000000000	439	xhKGfyogolM4ifNI-DsDOQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:07:25.98729+00	2025-01-24 18:07:57.809978+00	3uSJuIUv-zekgwEYKFrcVw	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	391	1uFCMKIxMk74EncVcIlgPA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 17:35:33.651401+00	2025-01-24 17:35:51.483391+00	H9XWpdW8fRmYNbvTkO5RVg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	440	Mpe0lWGazTjEGG46OiYStA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:07:57.810236+00	2025-01-24 18:08:05.818744+00	xhKGfyogolM4ifNI-DsDOQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	392	mU5GEcwUotKC6dktWjg0ow	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 17:35:51.48378+00	2025-01-24 17:46:11.024028+00	1uFCMKIxMk74EncVcIlgPA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	396	SDDYUPKUiaTcjpkEA49i3Q	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:00:37.034042+00	2025-01-24 18:00:41.765563+00	aVcrTEPbgUSiYNWF6ZaQnA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	144	CoC9NvHjjwVkFV1RaBPL_g	5e439340-f634-4871-bdc0-1fd7748ec3c9	t	2025-01-22 03:05:10.151632+00	2025-01-22 06:32:52.934501+00	\N	3f25d7e7-5e79-4691-bba3-03952e2d6201
00000000-0000-0000-0000-000000000000	154	S7tLyFBBb2bbpjdYGXV7HQ	5e439340-f634-4871-bdc0-1fd7748ec3c9	f	2025-01-22 06:32:52.935892+00	2025-01-22 06:32:52.935892+00	CoC9NvHjjwVkFV1RaBPL_g	3f25d7e7-5e79-4691-bba3-03952e2d6201
00000000-0000-0000-0000-000000000000	92	23SSAGHFQl3pmj1oDYd-4Q	5e439340-f634-4871-bdc0-1fd7748ec3c9	f	2025-01-22 00:38:52.151301+00	2025-01-22 00:38:52.151301+00	\N	8ad96a0b-b207-4fe9-a94b-f81a26c03464
00000000-0000-0000-0000-000000000000	93	J9-wrGgBAd6u83ud2cOAuA	5e439340-f634-4871-bdc0-1fd7748ec3c9	f	2025-01-22 00:39:01.143804+00	2025-01-22 00:39:01.143804+00	\N	fb0b89bc-33c4-4653-99ac-7120e59c8957
00000000-0000-0000-0000-000000000000	156	D02l7d9tn1q0Z6j6J6HC0Q	f3fbf22b-ce0f-4af9-85a2-ea2f88a9cb85	f	2025-01-22 11:48:44.778988+00	2025-01-22 11:48:44.778988+00	\N	bae7c4d2-e583-4f10-ab89-422dcd0625d6
00000000-0000-0000-0000-000000000000	96	lOxMoHI42hU9jFeYWWjV6w	5e439340-f634-4871-bdc0-1fd7748ec3c9	f	2025-01-22 01:05:31.67097+00	2025-01-22 01:05:31.67097+00	\N	a734c9f0-2e7c-477a-b8e3-138eef8160b0
00000000-0000-0000-0000-000000000000	157	uiTe8NWFtiSQvJndJSETYQ	f3fbf22b-ce0f-4af9-85a2-ea2f88a9cb85	f	2025-01-22 11:48:51.374233+00	2025-01-22 11:48:51.374233+00	\N	31e6c924-dd25-490c-9a34-f6bdb1fb074b
00000000-0000-0000-0000-000000000000	441	LRbNXDlBGrz_-1VgyKtTAw	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:08:05.81903+00	2025-01-24 18:08:12.751072+00	Mpe0lWGazTjEGG46OiYStA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	397	KTaOcSRi2iI9vyiVT2Vkkg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:00:41.765875+00	2025-01-24 18:00:46.155031+00	SDDYUPKUiaTcjpkEA49i3Q	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	163	BRQOFctmjUujbzBL792zAg	e7f95b31-2380-4d45-8692-43f9f37743ce	f	2025-01-23 08:02:13.26755+00	2025-01-23 08:02:13.26755+00	\N	0605a1a5-b792-4042-b173-9e05fbe85c33
00000000-0000-0000-0000-000000000000	165	Q2XZK63XOtcZJHy4Mmv_EA	e7f95b31-2380-4d45-8692-43f9f37743ce	f	2025-01-23 08:10:19.796842+00	2025-01-23 08:10:19.796842+00	\N	2004218b-88d3-4986-b125-13f74cc51383
00000000-0000-0000-0000-000000000000	167	bgdk7Dh-CSMONpv2-KZ1dQ	e7f95b31-2380-4d45-8692-43f9f37743ce	f	2025-01-23 08:19:16.116682+00	2025-01-23 08:19:16.116682+00	\N	d45af473-5978-4b56-94b0-4b844da0f629
00000000-0000-0000-0000-000000000000	170	6YmPE1on4n0etMSzHevvew	e7f95b31-2380-4d45-8692-43f9f37743ce	f	2025-01-23 08:32:16.914206+00	2025-01-23 08:32:16.914206+00	\N	5741ec44-2011-4f0a-a418-83b3512f1b1b
00000000-0000-0000-0000-000000000000	398	bliLHjZiWKXuRK9UCzbpsg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:00:46.155936+00	2025-01-24 18:00:57.8225+00	KTaOcSRi2iI9vyiVT2Vkkg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	442	jjkSdvK26TZuoe6KMmUemA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:08:12.751349+00	2025-01-24 18:08:31.613814+00	LRbNXDlBGrz_-1VgyKtTAw	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	399	9td-F27mU6hHlzubmoPyxA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:00:57.822853+00	2025-01-24 18:01:03.132315+00	bliLHjZiWKXuRK9UCzbpsg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	173	b3fArm_RlYMpm5lFZYQ6FA	e7f95b31-2380-4d45-8692-43f9f37743ce	f	2025-01-23 08:32:56.266229+00	2025-01-23 08:32:56.266229+00	\N	c57e8032-4b13-4203-988b-b9d3329411d5
00000000-0000-0000-0000-000000000000	400	u0vZzcJg5iFua1YkvFh50w	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:01:03.132637+00	2025-01-24 18:01:07.182854+00	9td-F27mU6hHlzubmoPyxA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	443	zmXK5KLs7o5msA7pnwU8KQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:08:31.614092+00	2025-01-24 18:09:07.987815+00	jjkSdvK26TZuoe6KMmUemA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	444	9d-VFWwqC7wFgQ2nmI4Ueg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:09:07.988078+00	2025-01-24 18:09:08.881016+00	zmXK5KLs7o5msA7pnwU8KQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	401	KYGkOVKpm1GcQkLlPvzf1g	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:01:07.183242+00	2025-01-24 18:01:50.136624+00	u0vZzcJg5iFua1YkvFh50w	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	402	ykyVo8vJ_IfAFxONXSPosA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:01:50.136922+00	2025-01-24 18:01:59.404907+00	KYGkOVKpm1GcQkLlPvzf1g	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	445	vxwj-1z9k7Y3qLb96olsBw	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:09:08.881318+00	2025-01-24 18:09:32.806165+00	9d-VFWwqC7wFgQ2nmI4Ueg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	403	Xid8FNjVsE-XdnOiXHj5SA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:01:59.405248+00	2025-01-24 18:02:04.861937+00	ykyVo8vJ_IfAFxONXSPosA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	404	Dyi9h8pNdzmiWGQEkm6LHg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:02:04.862237+00	2025-01-24 18:02:14.496332+00	Xid8FNjVsE-XdnOiXHj5SA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	446	BeHfyQdwid4oIjbcCCWDoQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:09:32.806426+00	2025-01-24 18:10:23.079559+00	vxwj-1z9k7Y3qLb96olsBw	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	405	sDk9JLzOAYQalxEwe0WYMg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:02:14.496606+00	2025-01-24 18:02:26.026965+00	Dyi9h8pNdzmiWGQEkm6LHg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	204	WataJIKDHs_Xk1Cp_BRrVw	e7f95b31-2380-4d45-8692-43f9f37743ce	f	2025-01-23 09:48:05.958769+00	2025-01-23 09:48:05.958769+00	\N	b35bcf4d-c6fe-43b4-a098-0aabe4eac8e2
00000000-0000-0000-0000-000000000000	406	nUkaqilATRkHQfL50uH7LQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:02:26.027516+00	2025-01-24 18:02:46.451195+00	sDk9JLzOAYQalxEwe0WYMg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	152	Aj7XNgkIb3a7iQ-efTG4yA	e7f95b31-2380-4d45-8692-43f9f37743ce	t	2025-01-22 06:22:03.508585+00	2025-01-23 15:03:50.692908+00	\N	d6ad9869-d16e-4e90-87fa-a307ebabeb61
00000000-0000-0000-0000-000000000000	447	lHgFhQStjmHFTpWyE3TEIQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:10:23.079871+00	2025-01-24 18:10:33.05405+00	BeHfyQdwid4oIjbcCCWDoQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	407	uRTbGzy2SpjGdKnwoilqnQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:02:46.451472+00	2025-01-24 18:02:51.784046+00	nUkaqilATRkHQfL50uH7LQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	448	vA4gDLgiV__cQUaGR3MKKA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:10:33.054357+00	2025-01-24 18:11:27.448628+00	lHgFhQStjmHFTpWyE3TEIQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	456	Auczx0HY89Jl7GpTrVI3cg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:15:00.468212+00	2025-01-24 18:15:03.121589+00	7MLCAweXFkrLDzQotT2l8Q	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	457	xjB8oODhi5QHYSLW26M9uA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:15:03.122713+00	2025-01-24 18:16:55.667222+00	Auczx0HY89Jl7GpTrVI3cg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	462	Wfr5DmUNu-1xgKa3KgN5rg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:23:44.176491+00	2025-01-24 18:32:41.851894+00	ekUamOkfKWvgI-JYwMYjOg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	466	Sfc58Oc99v7yDGpVXlbDSw	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:33:46.158144+00	2025-01-24 18:33:46.995878+00	qxZSGQS-OjP7KarCKNpmYQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	97	-NQYm0ZTuqzBRpMjAYGTLw	5e439340-f634-4871-bdc0-1fd7748ec3c9	t	2025-01-22 01:32:57.179907+00	2025-01-22 02:33:56.027368+00	\N	94c2925d-d4a3-4fb2-815b-a267e565fd40
00000000-0000-0000-0000-000000000000	134	0yH6ziipgQA6guqiMZaV9A	5e439340-f634-4871-bdc0-1fd7748ec3c9	f	2025-01-22 02:33:56.028092+00	2025-01-22 02:33:56.028092+00	-NQYm0ZTuqzBRpMjAYGTLw	94c2925d-d4a3-4fb2-815b-a267e565fd40
00000000-0000-0000-0000-000000000000	435	uJEs0en-UP-sBKZxRp47Eg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:06:32.301007+00	2025-01-24 18:07:16.741654+00	E0PXUglWbMv2UI5Gu4iGnw	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	136	nUv67_-6CzrF1yi1S0WhbA	5e439340-f634-4871-bdc0-1fd7748ec3c9	f	2025-01-22 02:34:08.4516+00	2025-01-22 02:34:08.4516+00	\N	13f6aad8-cbd4-403e-b2da-16ea8674fc86
00000000-0000-0000-0000-000000000000	449	_LgfNsZoomRb14SaClB7EQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:11:27.449326+00	2025-01-24 18:11:46.075829+00	vA4gDLgiV__cQUaGR3MKKA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	450	ts6EMsJka3ovIzzphyfGLg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:11:46.07616+00	2025-01-24 18:11:51.628566+00	_LgfNsZoomRb14SaClB7EQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	393	CHr0w9bDFmTpkAA0cmOSHA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 17:46:11.024794+00	2025-01-24 17:46:12.838074+00	mU5GEcwUotKC6dktWjg0ow	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	394	1QjF-w8MeqZAyQdbJu0qxw	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 17:46:12.838419+00	2025-01-24 17:59:32.753773+00	CHr0w9bDFmTpkAA0cmOSHA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	451	lWT29dyVghTX2qzeQv7kPw	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:11:51.628871+00	2025-01-24 18:11:52.951017+00	ts6EMsJka3ovIzzphyfGLg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	408	owK7f8SgYxdodkP8iKCttg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:02:51.785177+00	2025-01-24 18:03:02.8387+00	uRTbGzy2SpjGdKnwoilqnQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	409	-CgN4bovwlbsDt6yn3Wumw	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:03:02.838987+00	2025-01-24 18:03:10.785572+00	owK7f8SgYxdodkP8iKCttg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	452	8FSlZ0b_MXuyYjwDaR1eIg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:11:52.951365+00	2025-01-24 18:11:54.667189+00	lWT29dyVghTX2qzeQv7kPw	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	155	nLfkVMIA5P15px-exY6ugA	5e439340-f634-4871-bdc0-1fd7748ec3c9	f	2025-01-22 06:33:55.917296+00	2025-01-22 06:33:55.917296+00	\N	3848a159-2473-41d3-b692-720bf558edf3
00000000-0000-0000-0000-000000000000	410	Micqr5IwTFzq24LBeEEoXA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:03:10.785874+00	2025-01-24 18:03:15.123608+00	-CgN4bovwlbsDt6yn3Wumw	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	453	Xbtq6xaeBqgFFK2fSUvR9w	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:11:54.667503+00	2025-01-24 18:12:00.381551+00	8FSlZ0b_MXuyYjwDaR1eIg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	162	2YzpL-xmbAyY3IZtmToc3Q	e7f95b31-2380-4d45-8692-43f9f37743ce	f	2025-01-23 07:54:37.76063+00	2025-01-23 07:54:37.76063+00	\N	75076f23-d234-4c5b-8d00-ac067a566fde
00000000-0000-0000-0000-000000000000	164	UAiMn6WVPj0YRFJEJLveMg	e7f95b31-2380-4d45-8692-43f9f37743ce	f	2025-01-23 08:08:09.118774+00	2025-01-23 08:08:09.118774+00	\N	c3564852-acf8-4ab1-8078-184a0a14e717
00000000-0000-0000-0000-000000000000	166	wGVigZ85UiUXlwbYaIHI7w	e7f95b31-2380-4d45-8692-43f9f37743ce	f	2025-01-23 08:17:11.262711+00	2025-01-23 08:17:11.262711+00	\N	a7830c60-0cac-4f77-a162-ed4b6bcd742c
00000000-0000-0000-0000-000000000000	411	HapHrw4YOAU4ij2i4yjgEw	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:03:15.123895+00	2025-01-24 18:03:43.741544+00	Micqr5IwTFzq24LBeEEoXA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	168	pS4CfivkgKgSQzApuqb8WQ	e7f95b31-2380-4d45-8692-43f9f37743ce	f	2025-01-23 08:29:17.333862+00	2025-01-23 08:29:17.333862+00	\N	164b86ee-283b-46bf-9f31-64ef4e4af8a5
00000000-0000-0000-0000-000000000000	169	Amw4Mn3xTW8zYQ2j_ZlsXw	e7f95b31-2380-4d45-8692-43f9f37743ce	f	2025-01-23 08:29:59.483286+00	2025-01-23 08:29:59.483286+00	\N	106277dd-dea0-446c-84d8-6251b2e5a2ec
00000000-0000-0000-0000-000000000000	412	sVFciS_PGXzUQJyH3tE4SQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:03:43.741838+00	2025-01-24 18:03:49.305298+00	HapHrw4YOAU4ij2i4yjgEw	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	454	eseYJXuaq1V5lTVCiOsEtQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:12:00.382122+00	2025-01-24 18:12:02.203393+00	Xbtq6xaeBqgFFK2fSUvR9w	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	413	MBiIIRWjO6p9eAKrcgLAqg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:03:49.305638+00	2025-01-24 18:03:53.656484+00	sVFciS_PGXzUQJyH3tE4SQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	414	L8eUGLYFpYIGZ5FCkfZasA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:03:53.656753+00	2025-01-24 18:04:06.639628+00	MBiIIRWjO6p9eAKrcgLAqg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	415	1IpE5YbARHsyTExx56vPHQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:04:06.639911+00	2025-01-24 18:04:13.20749+00	L8eUGLYFpYIGZ5FCkfZasA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	416	sSRlRccbmX3V3Dk-vko6dw	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:04:13.207784+00	2025-01-24 18:04:23.030456+00	1IpE5YbARHsyTExx56vPHQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	417	lyGwpIwgbsFBZoL9RDGfoA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:04:23.030814+00	2025-01-24 18:04:32.652643+00	sSRlRccbmX3V3Dk-vko6dw	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	418	ihFnPEnX-dCXO1bD0DLzEA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:04:32.652897+00	2025-01-24 18:04:35.864126+00	lyGwpIwgbsFBZoL9RDGfoA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	419	C41YnPTYSIHLYq33qTY4HQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:04:35.864429+00	2025-01-24 18:04:39.812775+00	ihFnPEnX-dCXO1bD0DLzEA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	420	CrT2X8wZsqd_C2OVTpsoug	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:04:39.813064+00	2025-01-24 18:04:49.153147+00	C41YnPTYSIHLYq33qTY4HQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	199	z-aUhtEFf-J1OIg219-BLg	e7f95b31-2380-4d45-8692-43f9f37743ce	f	2025-01-23 09:21:13.223813+00	2025-01-23 09:21:13.223813+00	\N	d35d254a-6fae-4cad-8f4b-ed806e07c01a
00000000-0000-0000-0000-000000000000	421	StMWuP_7OEWyqwgNmTKMlA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:04:49.153418+00	2025-01-24 18:04:58.375181+00	CrT2X8wZsqd_C2OVTpsoug	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	422	pRuVv78P4biZNGDul5W_bQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:04:58.375465+00	2025-01-24 18:05:17.794131+00	StMWuP_7OEWyqwgNmTKMlA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	423	0a3DZgLxdC3X1de7kk_u3g	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:05:17.79441+00	2025-01-24 18:05:19.752147+00	pRuVv78P4biZNGDul5W_bQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	424	kCj7zVx3tWI6MkQXU7DLSA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:05:19.752421+00	2025-01-24 18:05:28.34631+00	0a3DZgLxdC3X1de7kk_u3g	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	425	4rlKzOi34vHlySI2MejjVg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:05:28.346646+00	2025-01-24 18:05:34.803265+00	kCj7zVx3tWI6MkQXU7DLSA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	426	33HWDxZfHZBhhU7RzgC-7Q	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:05:34.803547+00	2025-01-24 18:05:39.217874+00	4rlKzOi34vHlySI2MejjVg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	427	eeSGO5fbLKXQ4u-JnDf3bw	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:05:39.218158+00	2025-01-24 18:05:42.979964+00	33HWDxZfHZBhhU7RzgC-7Q	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	428	RGInyC2jK3j-1Zh1TBsrBw	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:05:42.980264+00	2025-01-24 18:05:51.714155+00	eeSGO5fbLKXQ4u-JnDf3bw	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	429	0mMv_73YCor1StUhOfxhZg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:05:51.714461+00	2025-01-24 18:05:59.583766+00	RGInyC2jK3j-1Zh1TBsrBw	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	430	gex3iNGx9Q8FPOdYeo7eNQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:05:59.584097+00	2025-01-24 18:06:08.621118+00	0mMv_73YCor1StUhOfxhZg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	431	nJU0V0L_Ub87FMJLthVEbQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:06:08.621382+00	2025-01-24 18:06:12.410573+00	gex3iNGx9Q8FPOdYeo7eNQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	432	CdBCKz8Tt18sLqw2f3vHzw	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:06:12.410868+00	2025-01-24 18:06:16.666624+00	nJU0V0L_Ub87FMJLthVEbQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	433	b_wlfVfQjC82BCEJTxEBXg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:06:16.666934+00	2025-01-24 18:06:29.38601+00	CdBCKz8Tt18sLqw2f3vHzw	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	434	E0PXUglWbMv2UI5Gu4iGnw	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:06:29.386285+00	2025-01-24 18:06:32.300719+00	b_wlfVfQjC82BCEJTxEBXg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	388	O3I3UWhEQp3j9NVJMP6V8A	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 17:30:49.503696+00	2025-01-24 17:30:53.243435+00	\N	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	455	7MLCAweXFkrLDzQotT2l8Q	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:12:02.203666+00	2025-01-24 18:15:00.467068+00	eseYJXuaq1V5lTVCiOsEtQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	389	fWR9CAnnB0NkD3KVUHGgfQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 17:30:53.243981+00	2025-01-24 17:30:58.6025+00	O3I3UWhEQp3j9NVJMP6V8A	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	390	H9XWpdW8fRmYNbvTkO5RVg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 17:30:58.602827+00	2025-01-24 17:35:33.649338+00	fWR9CAnnB0NkD3KVUHGgfQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	458	4QHcQcDR_U1uJ8mYpvVhzg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:16:55.667966+00	2025-01-24 18:16:58.260438+00	xjB8oODhi5QHYSLW26M9uA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	395	aVcrTEPbgUSiYNWF6ZaQnA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 17:59:32.754426+00	2025-01-24 18:00:37.032799+00	1QjF-w8MeqZAyQdbJu0qxw	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	459	WvryUdd62kKVFJlDz1eenQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:16:58.260772+00	2025-01-24 18:16:59.241461+00	4QHcQcDR_U1uJ8mYpvVhzg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	460	p8EnKbhPgCcsZfsiAlq-Ww	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:16:59.241792+00	2025-01-24 18:17:00.182077+00	WvryUdd62kKVFJlDz1eenQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	461	ekUamOkfKWvgI-JYwMYjOg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:17:00.184242+00	2025-01-24 18:23:44.175867+00	p8EnKbhPgCcsZfsiAlq-Ww	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	463	TcxlGY3Rx6CNsW7PQQfTpg	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:32:41.852529+00	2025-01-24 18:32:44.729633+00	Wfr5DmUNu-1xgKa3KgN5rg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	464	8i5L44U0m2JJ82fJ6e59UA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:32:44.729963+00	2025-01-24 18:32:46.297633+00	TcxlGY3Rx6CNsW7PQQfTpg	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	465	qxZSGQS-OjP7KarCKNpmYQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:32:46.297948+00	2025-01-24 18:33:46.157742+00	8i5L44U0m2JJ82fJ6e59UA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	467	eyG7AxsVtm84Ks9jrymDxA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:33:46.996266+00	2025-01-24 18:33:48.021441+00	Sfc58Oc99v7yDGpVXlbDSw	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	468	TOrN3mIfn0N91gZayJZ2jw	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:33:48.021862+00	2025-01-24 18:33:56.032383+00	eyG7AxsVtm84Ks9jrymDxA	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	469	U80PJbYxoNVElWBvoL241Q	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:33:56.03267+00	2025-01-24 18:33:58.791938+00	TOrN3mIfn0N91gZayJZ2jw	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	238	aveYlPmJKtJ1g4grT5woTQ	e7f95b31-2380-4d45-8692-43f9f37743ce	f	2025-01-23 15:03:50.700044+00	2025-01-23 15:03:50.700044+00	Aj7XNgkIb3a7iQ-efTG4yA	d6ad9869-d16e-4e90-87fa-a307ebabeb61
00000000-0000-0000-0000-000000000000	470	2MTAhwU6lcUxNNnFXCNOhQ	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	t	2025-01-24 18:33:58.792215+00	2025-01-24 18:36:27.689245+00	U80PJbYxoNVElWBvoL241Q	ae84abd7-270f-42dc-a89d-8c9d29614eb8
00000000-0000-0000-0000-000000000000	239	vMtUu5BqLeTE7V3uwbQkMA	e7f95b31-2380-4d45-8692-43f9f37743ce	t	2025-01-23 15:04:04.895947+00	2025-01-23 18:40:10.596533+00	\N	eb875597-6a9a-4da1-b496-608a88a28bf2
00000000-0000-0000-0000-000000000000	240	RQzC1NY7nvydSz52XSt1Cg	e7f95b31-2380-4d45-8692-43f9f37743ce	f	2025-01-23 18:40:10.599413+00	2025-01-23 18:40:10.599413+00	vMtUu5BqLeTE7V3uwbQkMA	eb875597-6a9a-4da1-b496-608a88a28bf2
00000000-0000-0000-0000-000000000000	471	hLgGplreE8NPQi9z3kTPbA	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	f	2025-01-24 18:36:27.690685+00	2025-01-24 18:36:27.690685+00	2MTAhwU6lcUxNNnFXCNOhQ	ae84abd7-270f-42dc-a89d-8c9d29614eb8
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."saml_providers" ("id", "sso_provider_id", "entity_id", "metadata_xml", "metadata_url", "attribute_mapping", "created_at", "updated_at", "name_id_format") FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."saml_relay_states" ("id", "sso_provider_id", "request_id", "for_email", "redirect_to", "created_at", "updated_at", "flow_state_id") FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."schema_migrations" ("version") FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag") FROM stdin;
d4803839-a798-4166-a39f-e5aefb615a1a	5e439340-f634-4871-bdc0-1fd7748ec3c9	2025-01-22 02:45:33.955236+00	2025-01-22 02:45:33.955236+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 Edg/132.0.0.0	99.73.114.206	\N
d02e862a-b66e-4e59-a94d-0fca43d82b7a	5e439340-f634-4871-bdc0-1fd7748ec3c9	2025-01-22 02:46:29.388047+00	2025-01-22 02:46:29.388047+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 Edg/132.0.0.0	99.73.114.206	\N
3f25d7e7-5e79-4691-bba3-03952e2d6201	5e439340-f634-4871-bdc0-1fd7748ec3c9	2025-01-22 03:05:10.150442+00	2025-01-22 06:32:52.938661+00	\N	aal1	\N	2025-01-22 06:32:52.938593	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 Edg/132.0.0.0	99.73.114.206	\N
bae7c4d2-e583-4f10-ab89-422dcd0625d6	f3fbf22b-ce0f-4af9-85a2-ea2f88a9cb85	2025-01-22 11:48:44.771373+00	2025-01-22 11:48:44.771373+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	108.59.189.225	\N
31e6c924-dd25-490c-9a34-f6bdb1fb074b	f3fbf22b-ce0f-4af9-85a2-ea2f88a9cb85	2025-01-22 11:48:51.372773+00	2025-01-22 11:48:51.372773+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	108.59.189.225	\N
8ad96a0b-b207-4fe9-a94b-f81a26c03464	5e439340-f634-4871-bdc0-1fd7748ec3c9	2025-01-22 00:38:52.150626+00	2025-01-22 00:38:52.150626+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 Edg/132.0.0.0	99.73.114.206	\N
fb0b89bc-33c4-4653-99ac-7120e59c8957	5e439340-f634-4871-bdc0-1fd7748ec3c9	2025-01-22 00:39:01.141831+00	2025-01-22 00:39:01.141831+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 Edg/132.0.0.0	99.73.114.206	\N
a734c9f0-2e7c-477a-b8e3-138eef8160b0	5e439340-f634-4871-bdc0-1fd7748ec3c9	2025-01-22 01:05:31.670274+00	2025-01-22 01:05:31.670274+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 Edg/132.0.0.0	99.73.114.206	\N
0605a1a5-b792-4042-b173-9e05fbe85c33	e7f95b31-2380-4d45-8692-43f9f37743ce	2025-01-23 08:02:13.264734+00	2025-01-23 08:02:13.264734+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	47.135.225.192	\N
2004218b-88d3-4986-b125-13f74cc51383	e7f95b31-2380-4d45-8692-43f9f37743ce	2025-01-23 08:10:19.794881+00	2025-01-23 08:10:19.794881+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	47.135.225.192	\N
d45af473-5978-4b56-94b0-4b844da0f629	e7f95b31-2380-4d45-8692-43f9f37743ce	2025-01-23 08:19:16.115515+00	2025-01-23 08:19:16.115515+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	47.135.225.192	\N
5741ec44-2011-4f0a-a418-83b3512f1b1b	e7f95b31-2380-4d45-8692-43f9f37743ce	2025-01-23 08:32:16.91321+00	2025-01-23 08:32:16.91321+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	47.135.225.192	\N
c57e8032-4b13-4203-988b-b9d3329411d5	e7f95b31-2380-4d45-8692-43f9f37743ce	2025-01-23 08:32:56.265461+00	2025-01-23 08:32:56.265461+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	47.135.225.192	\N
b35bcf4d-c6fe-43b4-a098-0aabe4eac8e2	e7f95b31-2380-4d45-8692-43f9f37743ce	2025-01-23 09:48:05.958159+00	2025-01-23 09:48:05.958159+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	47.135.225.192	\N
94c2925d-d4a3-4fb2-815b-a267e565fd40	5e439340-f634-4871-bdc0-1fd7748ec3c9	2025-01-22 01:32:57.176354+00	2025-01-22 02:33:56.030746+00	\N	aal1	\N	2025-01-22 02:33:56.03066	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 Edg/132.0.0.0	99.73.114.206	\N
13f6aad8-cbd4-403e-b2da-16ea8674fc86	5e439340-f634-4871-bdc0-1fd7748ec3c9	2025-01-22 02:34:08.450778+00	2025-01-22 02:34:08.450778+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 Edg/132.0.0.0	99.73.114.206	\N
3848a159-2473-41d3-b692-720bf558edf3	5e439340-f634-4871-bdc0-1fd7748ec3c9	2025-01-22 06:33:55.916197+00	2025-01-22 06:33:55.916197+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 Edg/132.0.0.0	99.73.114.206	\N
75076f23-d234-4c5b-8d00-ac067a566fde	e7f95b31-2380-4d45-8692-43f9f37743ce	2025-01-23 07:54:37.749976+00	2025-01-23 07:54:37.749976+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	47.135.225.192	\N
c3564852-acf8-4ab1-8078-184a0a14e717	e7f95b31-2380-4d45-8692-43f9f37743ce	2025-01-23 08:08:09.113543+00	2025-01-23 08:08:09.113543+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	47.135.225.192	\N
a7830c60-0cac-4f77-a162-ed4b6bcd742c	e7f95b31-2380-4d45-8692-43f9f37743ce	2025-01-23 08:17:11.260947+00	2025-01-23 08:17:11.260947+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	47.135.225.192	\N
164b86ee-283b-46bf-9f31-64ef4e4af8a5	e7f95b31-2380-4d45-8692-43f9f37743ce	2025-01-23 08:29:17.332662+00	2025-01-23 08:29:17.332662+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	47.135.225.192	\N
106277dd-dea0-446c-84d8-6251b2e5a2ec	e7f95b31-2380-4d45-8692-43f9f37743ce	2025-01-23 08:29:59.48116+00	2025-01-23 08:29:59.48116+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	47.135.225.192	\N
d35d254a-6fae-4cad-8f4b-ed806e07c01a	e7f95b31-2380-4d45-8692-43f9f37743ce	2025-01-23 09:21:13.223211+00	2025-01-23 09:21:13.223211+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	47.135.225.192	\N
d6ad9869-d16e-4e90-87fa-a307ebabeb61	e7f95b31-2380-4d45-8692-43f9f37743ce	2025-01-22 06:22:03.507647+00	2025-01-23 15:03:50.705786+00	\N	aal1	\N	2025-01-23 15:03:50.705701	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Mobile Safari/537.36	47.135.225.192	\N
eb875597-6a9a-4da1-b496-608a88a28bf2	e7f95b31-2380-4d45-8692-43f9f37743ce	2025-01-23 15:04:04.895139+00	2025-01-23 18:40:10.602271+00	\N	aal1	\N	2025-01-23 18:40:10.6022	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Mobile Safari/537.36	47.135.225.192	\N
ae84abd7-270f-42dc-a89d-8c9d29614eb8	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	2025-01-24 17:30:49.502121+00	2025-01-24 18:36:27.693175+00	\N	aal1	\N	2025-01-24 18:36:27.693102	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	47.135.225.192	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sso_domains" ("id", "sso_provider_id", "domain", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sso_providers" ("id", "resource_id", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous", "is_admin") FROM stdin;
00000000-0000-0000-0000-000000000000	e7f95b31-2380-4d45-8692-43f9f37743ce	authenticated	authenticated	tomlit@gmail.com	$2a$10$z4xiDfxLMOswkZK..Y2QkejZUQQ2.p/Z9aUaBI4KJISmDRRIkHcam	2025-01-21 23:48:54.857708+00	\N		2025-01-21 23:48:43.343839+00		\N			\N	2025-01-23 15:04:04.895065+00	{"provider": "email", "providers": ["email", "discord"]}	{"iss": "https://discord.com/api", "sub": "168922384357785600", "name": "tomlit#0", "email": "tomlit@gmail.com", "picture": "https://cdn.discordapp.com/avatars/168922384357785600/26c24efb5e7aa53a294bd1f700af3b7d.png", "full_name": "tomlit", "avatar_url": "https://cdn.discordapp.com/avatars/168922384357785600/26c24efb5e7aa53a294bd1f700af3b7d.png", "provider_id": "168922384357785600", "custom_claims": {"global_name": "tomlit"}, "email_verified": true, "phone_verified": false}	\N	2025-01-21 23:48:43.332103+00	2025-01-26 19:24:59.146764+00	\N	\N			\N		0	\N		\N	f	\N	f	f
00000000-0000-0000-0000-000000000000	16bfe819-65d8-4e79-a96c-9b82765bd239	authenticated	authenticated	joenilan@gmail.com	$2a$10$sEjAH7FUsHRSHm3eeIOHnub6Qua91yGwunRn3T3ZRMHUhOwsLgh.S	2025-01-22 00:03:05.185991+00	\N		2025-01-22 00:02:58.682523+00		\N			\N	2025-01-22 00:17:42.876763+00	{"provider": "email", "providers": ["email"]}	{"sub": "16bfe819-65d8-4e79-a96c-9b82765bd239", "email": "joenilan@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-01-22 00:02:58.673561+00	2025-01-22 00:17:42.881148+00	\N	\N			\N		0	\N		\N	f	\N	f	f
00000000-0000-0000-0000-000000000000	f3fbf22b-ce0f-4af9-85a2-ea2f88a9cb85	authenticated	authenticated	nickolasheisler@gmail.com	$2a$10$SppoM7Ct2YZngpHHAGC2cenWIIpQC0/KvhTkbNZJEuUgud0NNANIa	2025-01-22 11:48:44.767374+00	\N		2025-01-22 11:48:26.356504+00		\N			\N	2025-01-22 11:48:51.372691+00	{"provider": "email", "providers": ["email"]}	{"sub": "f3fbf22b-ce0f-4af9-85a2-ea2f88a9cb85", "email": "nickolasheisler@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-01-22 11:48:26.292679+00	2025-01-22 11:48:51.375843+00	\N	\N			\N		0	\N		\N	f	\N	f	f
00000000-0000-0000-0000-000000000000	5e439340-f634-4871-bdc0-1fd7748ec3c9	authenticated	authenticated	gaytan2012@gmail.com	$2a$10$vxSnFAGbeavqgRDM8h4SReInSAXh/dFXArEjWAtkkG/xosNQcu5oC	2025-01-22 00:38:52.147458+00	\N		2025-01-22 00:38:39.314267+00		\N			\N	2025-01-22 06:33:55.916131+00	{"provider": "email", "providers": ["email"]}	{"sub": "5e439340-f634-4871-bdc0-1fd7748ec3c9", "email": "gaytan2012@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-01-22 00:38:39.3048+00	2025-01-22 06:33:55.918631+00	\N	\N			\N		0	\N		\N	f	\N	f	f
00000000-0000-0000-0000-000000000000	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	authenticated	admin	serenyxproduction@gmail.com	$2a$10$BciAQ/TeMdkO02JPzV0jt.mZKXL.tRLYukNNkX9FPlcBmxzaiVrSu	2025-01-21 20:41:49.761134+00	\N		2025-01-21 20:41:34.804497+00		\N			\N	2025-01-24 17:30:49.502049+00	{"provider": "email", "providers": ["email"]}	{"sub": "2eb0f80e-20cb-48ba-900a-32c311d9dfcf", "email": "serenyxproduction@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-01-21 20:41:34.784806+00	2025-01-24 18:36:27.691909+00	\N	\N			\N		0	\N		\N	f	\N	f	t
\.


--
-- Data for Name: key; Type: TABLE DATA; Schema: pgsodium; Owner: supabase_admin
--

COPY "pgsodium"."key" ("id", "status", "created", "expires", "key_type", "key_id", "key_context", "name", "associated_data", "raw_key", "raw_key_nonce", "parent_key", "comment", "user_data") FROM stdin;
\.


--
-- Data for Name: matches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."matches" ("id", "created_at", "team1_id", "team2_id", "team1_score", "team2_score", "status", "tournament_id", "division", "start_time") FROM stdin;
528cb6aa-cb7e-4fef-9555-f7ad69bc9a4d	2025-01-21 22:05:19.241795+00	e00647fd-a4c9-442c-bffc-522cf7c52c0c	873a7173-d558-4f90-ad6b-f72af698f53a	4	1	completed	\N	I	2025-01-21 17:05:00+00
41b76c45-b6cf-4f4b-a323-d49c38fbd15b	2025-01-21 22:04:33.790621+00	1782201c-2f1e-4f4f-b217-2b0f2422db0f	c59fe217-9e7d-4b55-9c6d-c8dd1e470b98	0	0	upcoming	\N	II	2025-01-25 14:05:00+00
9ea93af7-8f14-4692-9a06-53d523c8e3c7	2025-01-21 22:04:04.16223+00	e00647fd-a4c9-442c-bffc-522cf7c52c0c	873a7173-d558-4f90-ad6b-f72af698f53a	0	0	live	\N	I	2025-01-25 12:05:00+00
30b31741-2806-4039-9ae3-13c80cdbb22c	2025-01-22 00:57:09.016124+00	d2686510-f83d-4022-868d-3d191be5fa0f	42831afb-d719-4e9a-8abf-6786641d0751	2	0	live	\N	God Division 	2025-01-24 14:55:00+00
add3dd88-1be0-4fbd-8575-fbfe871696e4	2025-01-21 22:04:56.973116+00	4256ebcb-18e6-4087-b813-bd498d42751a	8e652e03-2747-491e-8686-314b58944bea	0	0	live	\N	III	2025-01-25 16:05:00+00
\.


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."players" ("id", "created_at", "name", "team_id", "stats") FROM stdin;
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."teams" ("id", "created_at", "name", "division", "wins", "losses", "points", "logo_url") FROM stdin;
4256ebcb-18e6-4087-b813-bd498d42751a	2025-01-21 21:58:02.266463+00	NRG	III	0	0	0	
c59fe217-9e7d-4b55-9c6d-c8dd1e470b98	2025-01-21 21:57:06.192718+00	Team Serenyx	II	0	0	0	
1782201c-2f1e-4f4f-b217-2b0f2422db0f	2025-01-21 21:58:31.676144+00	Team Schizzz	II	0	0	0	
8e652e03-2747-491e-8686-314b58944bea	2025-01-21 21:58:49.581662+00	Spacestation Gaming	III	0	0	0	
873a7173-d558-4f90-ad6b-f72af698f53a	2025-01-21 21:59:19.737232+00	Team Plat	I	0	0	0	
e00647fd-a4c9-442c-bffc-522cf7c52c0c	2025-01-21 21:59:47.496892+00	Team Demo	I	0	0	0	
d2686510-f83d-4022-868d-3d191be5fa0f	2025-01-22 00:54:15.181409+00	GAYTANA	God Division 	0	0	0	
42831afb-d719-4e9a-8abf-6786641d0751	2025-01-22 00:55:18.021581+00	VXDQA	God Division 	0	0	0	
\.


--
-- Data for Name: tournaments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."tournaments" ("id", "created_at", "name", "start_date", "end_date", "status", "prize_pool", "format") FROM stdin;
\.


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."versions" ("id", "created_at", "document_type", "content", "created_by", "version_number", "is_current") FROM stdin;
661f047d-932c-4c56-9bb5-ecd15e41148c	2025-01-22 02:26:56.334213+00	changelog	# Changelog\n\n## Version 0.1.0 (Current)\n\n### ✨ New Features\n- Match overlay system with real-time score updates\n- Team standings display with division breakdowns\n- Broadcast script editor with markdown support\n- Dark/Light mode toggle\n- Authentication system with Supabase\n- Responsive admin dashboard\n- OBS URL generation for overlays\n\n### 🐛 Known Issues\n- [ ] Copy button not working for OBS URLs\n- [ ] Division standings click state not expanding properly\n- [ ] Series scores not updating consistently across sections\n- [ ] Overlay data needs to be converted to real-time updates\n\n### 🚧 In Progress\n- Real-time data synchronization\n- Team management system\n- Match history tracking\n\n### ✅ Completed\n- Basic authentication flow\n- Admin dashboard layout\n- Broadcast script editor\n- Dark/light mode implementation\n- Initial overlay system\n- Team standings display\n- Match overlay base functionality\n\n### 📋 Planned Features\n- Tournament bracket system\n- Player statistics tracking\n- Advanced overlay customization\n- Team profile pages\n- Match scheduling system\n- Automated social media updates\n\n## Development Notes\n\n### Priority Tasks\n1. Fix real-time data synchronization\n2. Implement proper error handling\n3. Add comprehensive logging\n4. Complete team management system\n\n### Recent Updates\n- Added dark/light mode toggle\n- Implemented broadcast script editor\n- Set up basic overlay system\n- Created team standings display\n- Implemented match overlay base functionality	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	1	f
58864494-2588-473f-9cba-7d4d6c7e11b1	2025-01-22 02:28:36.18637+00	changelog	# Changelog\n\n## Version 0.1.0 (Current)\n\n### ✨ New Features\n- Match overlay system with real-time score updates\n- Team standings display with division breakdowns\n- Broadcast script editor with markdown support\n- Dark/Light mode toggle\n- Authentication system with Supabase\n- Responsive admin dashboard\n- OBS URL generation for overlays\n\n### 🐛 Known Issues\n- [ ] Copy button not working for OBS URLs\n- [ ] Division standings click state not expanding properly\n- [ ] Series scores not updating consistently across sections\n- [ ] Overlay data needs to be converted to real-time updates\n\n### 🚧 In Progress\n- Real-time data synchronization\n- Team management system\n- Match history tracking\n\n### ✅ Completed\n- Basic authentication flow\n- Admin dashboard layout\n- Broadcast script editor\n- Dark/light mode implementation\n- Initial overlay system\n- Team standings display\n- Match overlay base functionality\n\n### 📋 Planned Features\n- Tournament bracket system\n- Player statistics tracking\n- Advanced overlay customization\n- Team profile pages\n- Match scheduling system\n- Automated social media updates\n\n## Development Notes\n\n### Priority Tasks\n1. Fix real-time data synchronization\n2. Implement proper error handling\n3. Add comprehensive logging\n4. Complete team management system\n\n### Recent Updates\n- Added dark/light mode toggle\n- Implemented broadcast script editor\n- Set up basic overlay system\n- Created team standings display\n- Implemented match overlay base functionality	e7f95b31-2380-4d45-8692-43f9f37743ce	2	t
a007a9fa-eb41-4ddd-b623-98d4dd48cdf2	2025-01-22 02:16:10.847761+00	broadcast_script	\n\n## Pre-Show (30 minutes)\n\n- Opening animation featuring the logo, Fennec decal design with dynamic red and black particle effects\n- Openingsegment: Analysis desk with 2-3 commentators discussing:\n  - Previous tournament results or intro to the tournament if first stream\n  - Team power rankings\n  - Key players to watch\n  - Bracket predictions\n\n## Match Coverage\n\n### Custom overlay elements:\n- Team scores with animated Serenyx logo transitions\n- Player stats panel showing:\n  - Goals/Assists/Saves\n  - Boost meter\n  - Stat trackers\n- Series score tracker\n\n### Between Games Content:\n- Highlight analysis with telestration tools\n- Quick technical breakdown of notable plays\n\n## Post-Show Segments\n- Winner interviews\n- Tournament recap and standings update\n- Preview of upcoming events\n\n## Special Production Elements\n\n### Custom Graphics Package\n- Geometric transitions using the Serenyx logo elements\n- Lower thirds with red/black gradient animations\n- Team introduction screens with player cards (if available)\n- Stats overlays with minimalist design matching brand\n- Countdown timers with custom Fennec silhouettes\n\n### Interactive Elements\n- Live Twitter feed integration with custom hashtag\n- Fan prediction polls during breaks\n- Live tournament bracket updates\n\n## Technical Setup for OBS\n\n### Scene Collection:\n- Pre-show desk layout\n- Main match overlay\n- Analysis screen with split replay capability\n- Post-game stats screen\n- Social media integration panel\n- Transition scenes with animated Serenyx elements\n\n## Unique Segment I\n- "Serenyx Spotlight" - Feature on a rising team/player\n- "Division Rundown" - Coverage of all 4 divisions\n- "Community Corner" - Highlighting community clips/plays	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	1	f
dd6b348a-9535-49f0-92de-57cd6e6532d0	2025-01-22 02:17:25.897105+00	broadcast_script	\n\n## Pre-Show (30 minutes)\n\n- Opening animation featuring the logo, Fennec decal design with dynamic red and black particle effects\n- Openingsegment: Analysis desk with 2-3 commentators discussing:\n  - Previous tournament results or intro to the tournament if first stream\n  - Team power rankings\n  - Key players to watch\n  - Bracket predictions\n\n## Match Coverage\n\n### Custom overlay elements:\n- Team scores with animated Serenyx logo transitions\n- Player stats panel showing:\n  - Goals/Assists/Saves\n  - Boost meter\n  - Stat trackers\n- Series score tracker\n\n### Between Games Content:\n- Highlight analysis with telestration tools\n- Quick technical breakdown of notable plays\n\n## Post-Show Segments\n- Winner interviews\n- Tournament recap and standings update\n- Preview of upcoming events\n\n## Special Production Elements\n\n### Custom Graphics Package\n- Geometric transitions using the Serenyx logo elements\n- Lower thirds with red/black gradient animations\n- Team introduction screens with player cards (if available)\n- Stats overlays with minimalist design matching brand\n- Countdown timers with custom Fennec silhouettes\n\n### Interactive Elements\n- Live Twitter feed integration with custom hashtag\n- Fan prediction polls during breaks\n- Live tournament bracket updates\n\n## Technical Setup for OBS\n\n### Scene Collection:\n- Pre-show desk layout\n- Main match overlay\n- Analysis screen with split replay capability\n- Post-game stats screen\n- Social media integration panel\n- Transition scenes with animated Serenyx elements\n\n## Unique Segment I\n- "Serenyx Spotlight" - Feature on a rising team/player\n- "Division Rundown" - Coverage of all 4 divisions\n- "Community Corner" - Highlighting community clips/plays	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	2	f
49bb6a40-b3a8-4e46-9047-919f64ab7b71	2025-01-22 02:17:48.128802+00	broadcast_script	\n\n## Pre-Show (30 minutes)\n\n- Opening animation featuring the logo, Fennec decal design with dynamic red and black particle effects\n- Openingsegment: Analysis desk with 2-3 commentators discussing:\n  - Previous tournament results or intro to the tournament if first stream\n  - Team power rankings\n  - Key players to watch\n  - Bracket predictionss\n\n## Match Coverage\n\n### Custom overlay elements:\n- Team scores with animated Serenyx logo transitions\n- Player stats panel showing:\n  - Goals/Assists/Saves\n  - Boost meter\n  - Stat trackers\n- Series score tracker\n\n### Between Games Content:\n- Highlight analysis with telestration tools\n- Quick technical breakdown of notable plays\n\n## Post-Show Segments\n- Winner interviews\n- Tournament recap and standings update\n- Preview of upcoming events\n\n## Special Production Elements\n\n### Custom Graphics Package\n- Geometric transitions using the Serenyx logo elements\n- Lower thirds with red/black gradient animations\n- Team introduction screens with player cards (if available)\n- Stats overlays with minimalist design matching brand\n- Countdown timers with custom Fennec silhouettes\n\n### Interactive Elements\n- Live Twitter feed integration with custom hashtag\n- Fan prediction polls during breaks\n- Live tournament bracket updates\n\n## Technical Setup for OBS\n\n### Scene Collection:\n- Pre-show desk layout\n- Main match overlay\n- Analysis screen with split replay capability\n- Post-game stats screen\n- Social media integration panel\n- Transition scenes with animated Serenyx elements\n\n## Unique Segment I\n- "Serenyx Spotlight" - Feature on a rising team/player\n- "Division Rundown" - Coverage of all 4 divisions\n- "Community Corner" - Highlighting community clips/plays	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	3	f
cd2e194d-ab9d-426b-acbb-dab6a8480329	2025-01-22 02:24:51.596695+00	broadcast_script	\n\n## Pre-Show (30 minutes)\n\n- Opening animation featuring the logo, Fennec decal design with dynamic red and black particle effects\n- Openingsegment: Analysis desk with 2-3 commentators discussing:\n  - Previous tournament results or intro to the tournament if first stream\n  - Team power rankings\n  - Key players to watch\n  - Bracket predictions\n\n## Match Coverage\n\n### Custom overlay elements:\n- Team scores with animated Serenyx logo transitions\n- Player stats panel showing:\n  - Goals/Assists/Saves\n  - Boost meter\n  - Stat trackers\n- Series score tracker\n\n### Between Games Content:\n- Highlight analysis with telestration tools\n- Quick technical breakdown of notable plays\n\n## Post-Show Segments\n- Winner interviews\n- Tournament recap and standings update\n- Preview of upcoming events\n\n## Special Production Elements\n\n### Custom Graphics Package\n- Geometric transitions using the Serenyx logo elements\n- Lower thirds with red/black gradient animations\n- Team introduction screens with player cards (if available)\n- Stats overlays with minimalist design matching brand\n- Countdown timers with custom Fennec silhouettes\n\n### Interactive Elements\n- Live Twitter feed integration with custom hashtag\n- Fan prediction polls during breaks\n- Live tournament bracket updates\n\n## Technical Setup for OBS\n\n### Scene Collection:\n- Pre-show desk layout\n- Main match overlay\n- Analysis screen with split replay capability\n- Post-game stats screen\n- Social media integration panel\n- Transition scenes with animated Serenyx elements\n\n## Unique Segment I\n- "Serenyx Spotlight" - Feature on a rising team/player\n- "Division Rundown" - Coverage of all 4 divisions\n- "Community Corner" - Highlighting community clips/plays	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	4	f
5372d0a0-cfce-4dfb-a9be-3d292e5f6498	2025-01-22 02:25:27.441759+00	broadcast_script	## Pre-Show (30 minutes)\n\n- Opening animation featuring the logo, Fennec decal design with dynamic red and black particle effects\n- Openingsegment: Analysis desk with 2-3 commentators discussing:\n  - Previous tournament results or intro to the tournament if first stream\n  - Team power rankings\n  - Key players to watch\n  - Bracket predictions\n\n## Match Coverage\n\n### Custom overlay elements:\n- Team scores with animated Serenyx logo transitions\n- Player stats panel showing:\n  - Goals/Assists/Saves\n  - Boost meter\n  - Stat trackers\n- Series score tracker\n\n### Between Games Content:\n- Highlight analysis with telestration tools\n- Quick technical breakdown of notable plays\n\n## Post-Show Segments\n- Winner interviews\n- Tournament recap and standings update\n- Preview of upcoming events\n\n## Special Production Elements\n\n### Custom Graphics Package\n- Geometric transitions using the Serenyx logo elements\n- Lower thirds with red/black gradient animations\n- Team introduction screens with player cards (if available)\n- Stats overlays with minimalist design matching brand\n- Countdown timers with custom Fennec silhouettes\n\n### Interactive Elements\n- Live Twitter feed integration with custom hashtag\n- Fan prediction polls during breaks\n- Live tournament bracket updates\n\n## Technical Setup for OBS\n\n### Scene Collection:\n- Pre-show desk layout\n- Main match overlay\n- Analysis screen with split replay capability\n- Post-game stats screen\n- Social media integration panel\n- Transition scenes with animated Serenyx elements\n\n## Unique Segment I\n- "Serenyx Spotlight" - Feature on a rising team/player\n- "Division Rundown" - Coverage of all 4 divisions\n- "Community Corner" - Highlighting community clips/plays	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	5	f
211b4b96-62b5-4c72-b77c-546e8de4ea8a	2025-01-22 02:27:17.250219+00	broadcast_script	\n\n## Pre-Show (30 minutes)\n\n- Opening animation featuring the logo, Fennec decal design with dynamic red and black particle effects\n- Openingsegment: Analysis desk with 2-3 commentators discussing:\n  - Previous tournament results or intro to the tournament if first stream\n  - Team power rankings\n  - Key players to watch\n  - Bracket predictions\n\n## Match Coverage\n\n### Custom overlay elements:\n- Team scores with animated Serenyx logo transitions\n- Player stats panel showing:\n  - Goals/Assists/Saves\n  - Boost meter\n  - Stat trackers\n- Series score tracker\n\n### Between Games Content:\n- Highlight analysis with telestration tools\n- Quick technical breakdown of notable plays\n\n## Post-Show Segments\n- Winner interviews\n- Tournament recap and standings update\n- Preview of upcoming events\n\n## Special Production Elements\n\n### Custom Graphics Package\n- Geometric transitions using the Serenyx logo elements\n- Lower thirds with red/black gradient animations\n- Team introduction screens with player cards (if available)\n- Stats overlays with minimalist design matching brand\n- Countdown timers with custom Fennec silhouettes\n\n### Interactive Elements\n- Live Twitter feed integration with custom hashtag\n- Fan prediction polls during breaks\n- Live tournament bracket updates\n\n## Technical Setup for OBS\n\n### Scene Collection:\n- Pre-show desk layout\n- Main match overlay\n- Analysis screen with split replay capability\n- Post-game stats screen\n- Social media integration panel\n- Transition scenes with animated Serenyx elements\n\n## Unique Segment I\n- "Serenyx Spotlight" - Feature on a rising team/player\n- "Division Rundown" - Coverage of all 4 divisions\n- "Community Corner" - Highlighting community clips/plays	2eb0f80e-20cb-48ba-900a-32c311d9dfcf	6	f
aa0482e2-4078-40d4-ab23-13600e540318	2025-01-22 02:28:51.321107+00	broadcast_script	## Pre-Show (30 minutes)\n\n- Opening animation featuring the logo, Fennec decal design with dynamic red and black particle effects\n- Openingsegment: Analysis desk with 2-3 commentators discussing:\n  - Previous tournament results or intro to the tournament if first stream\n  - Team power rankings\n  - Key players to watch\n  - Bracket predictions\n\n## Match Coverage\n\n### Custom overlay elements:\n- Team scores with animated Serenyx logo transitions\n- Player stats panel showing:\n  - Goals/Assists/Saves\n  - Boost meter\n  - Stat trackers\n- Series score tracker\n\n### Between Games Content:\n- Highlight analysis with telestration tools\n- Quick technical breakdown of notable plays\n\n## Post-Show Segments\n- Winner interviews\n- Tournament recap and standings update\n- Preview of upcoming events\n\n## Special Production Elements\n\n### Custom Graphics Package\n- Geometric transitions using the Serenyx logo elements\n- Lower thirds with red/black gradient animations\n- Team introduction screens with player cards (if available)\n- Stats overlays with minimalist design matching brand\n- Countdown timers with custom Fennec silhouettes\n\n### Interactive Elements\n- Live Twitter feed integration with custom hashtag\n- Fan prediction polls during breaks\n- Live tournament bracket updates\n\n## Technical Setup for OBS\n\n### Scene Collection:\n- Pre-show desk layout\n- Main match overlay\n- Analysis screen with split replay capability\n- Post-game stats screen\n- Social media integration panel\n- Transition scenes with animated Serenyx elements\n\n## Unique Segment I\n- "Serenyx Spotlight" - Feature on a rising team/player\n- "Division Rundown" - Coverage of all 4 divisions\n- "Community Corner" - Highlighting community clips/plays	e7f95b31-2380-4d45-8692-43f9f37743ce	7	f
eefc6c1a-42f1-4a3c-9945-6c67b1713f2b	2025-01-22 02:48:19.05746+00	broadcast_script	## Pre-Show (30 minutes)\n\n- Opening animation featuring the logo, Fennec decal design with dynamic red and black particle effects\n- Openingsegment: Analysis desk with 2-3 commentators discussing:\n  - Previous tournament results or intro to the tournament if first stream\n  - Team power rankings\n  - Key players to watch\n  - Bracket predictions\n\n## Match Coverage\n\n### Custom overlay elements:\n- Team scores with animated Serenyx logo transitions\n- Player stats panel showing:\n  - Goals/Assists/Saves\n  - Boost meter\n  - Stat trackers\n- Series score tracker\n\n### Between Games Content:\n- Highlight analysis with telestration tools\n- Quick technical breakdown of notable plays\n\n## Post-Show Segments\n- Winner interviews\n- Tournament recap and standings update\n- Preview of upcoming events\n\n## Special Production Elements\n\n### Custom Graphics Package\n- Geometric transitions using the Serenyx logo elements\n- Lower thirds with red/black gradient animations\n- Team introduction screens with player cards (if available)\n- Stats overlays with minimalist design matching brand\n- Countdown timers with custom Fennec silhouettes\n\n### Interactive Elements\n- Live Twitter feed integration with custom hashtag\n- Fan prediction polls during breaks\n- Live tournament bracket updates\n\n## Technical Setup for OBS\n\n### Scene Collection:\n- Pre-show desk layout\n- Main match overlay\n- Analysis screen with split replay capability\n- Post-game stats screen\n- Social media integration panel\n- Transition scenes with animated Serenyx elements\n\n## Unique Segment I\n- "Serenyx Spotlight" - Feature on a rising team/player\n- "Division Rundown" - Coverage of all 4 divisions\n- "Community Corner" - Highlighting community clips/plays	5e439340-f634-4871-bdc0-1fd7748ec3c9	8	t
\.


--
-- Data for Name: messages_2025_01_20; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY "realtime"."messages_2025_01_20" ("topic", "extension", "payload", "event", "private", "updated_at", "inserted_at", "id") FROM stdin;
\.


--
-- Data for Name: messages_2025_01_21; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY "realtime"."messages_2025_01_21" ("topic", "extension", "payload", "event", "private", "updated_at", "inserted_at", "id") FROM stdin;
\.


--
-- Data for Name: messages_2025_01_22; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY "realtime"."messages_2025_01_22" ("topic", "extension", "payload", "event", "private", "updated_at", "inserted_at", "id") FROM stdin;
\.


--
-- Data for Name: messages_2025_01_23; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY "realtime"."messages_2025_01_23" ("topic", "extension", "payload", "event", "private", "updated_at", "inserted_at", "id") FROM stdin;
\.


--
-- Data for Name: messages_2025_01_24; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY "realtime"."messages_2025_01_24" ("topic", "extension", "payload", "event", "private", "updated_at", "inserted_at", "id") FROM stdin;
\.


--
-- Data for Name: messages_2025_01_25; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY "realtime"."messages_2025_01_25" ("topic", "extension", "payload", "event", "private", "updated_at", "inserted_at", "id") FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY "realtime"."schema_migrations" ("version", "inserted_at") FROM stdin;
20211116024918	2025-01-21 20:19:46
20211116045059	2025-01-21 20:19:46
20211116050929	2025-01-21 20:19:46
20211116051442	2025-01-21 20:19:46
20211116212300	2025-01-21 20:19:46
20211116213355	2025-01-21 20:19:46
20211116213934	2025-01-21 20:19:47
20211116214523	2025-01-21 20:19:47
20211122062447	2025-01-21 20:19:47
20211124070109	2025-01-21 20:19:47
20211202204204	2025-01-21 20:19:47
20211202204605	2025-01-21 20:19:47
20211210212804	2025-01-21 20:19:47
20211228014915	2025-01-21 20:19:47
20220107221237	2025-01-21 20:19:47
20220228202821	2025-01-21 20:19:47
20220312004840	2025-01-21 20:19:47
20220603231003	2025-01-21 20:19:47
20220603232444	2025-01-21 20:19:47
20220615214548	2025-01-21 20:19:47
20220712093339	2025-01-21 20:19:47
20220908172859	2025-01-21 20:19:47
20220916233421	2025-01-21 20:19:47
20230119133233	2025-01-21 20:19:47
20230128025114	2025-01-21 20:19:47
20230128025212	2025-01-21 20:19:47
20230227211149	2025-01-21 20:19:47
20230228184745	2025-01-21 20:19:47
20230308225145	2025-01-21 20:19:47
20230328144023	2025-01-21 20:19:47
20231018144023	2025-01-21 20:19:47
20231204144023	2025-01-21 20:19:47
20231204144024	2025-01-21 20:19:47
20231204144025	2025-01-21 20:19:47
20240108234812	2025-01-21 20:19:47
20240109165339	2025-01-21 20:19:47
20240227174441	2025-01-21 20:19:47
20240311171622	2025-01-21 20:19:47
20240321100241	2025-01-21 20:19:47
20240401105812	2025-01-21 20:19:47
20240418121054	2025-01-21 20:19:47
20240523004032	2025-01-21 20:19:47
20240618124746	2025-01-21 20:19:47
20240801235015	2025-01-21 20:19:47
20240805133720	2025-01-21 20:19:47
20240827160934	2025-01-21 20:19:47
20240919163303	2025-01-21 20:19:48
20240919163305	2025-01-21 20:19:48
20241019105805	2025-01-21 20:19:48
20241030150047	2025-01-21 20:19:48
20241108114728	2025-01-21 20:19:48
20241121104152	2025-01-21 20:19:48
20241130184212	2025-01-21 20:19:48
20241220035512	2025-01-21 20:19:48
20241220123912	2025-01-21 20:19:48
20241224161212	2025-01-21 20:19:48
20250107150512	2025-01-21 20:19:48
20250110162412	2025-01-21 20:19:48
20250123174212	2025-01-24 15:47:00
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY "realtime"."subscription" ("id", "subscription_id", "entity", "filters", "claims", "created_at") FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id") FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."migrations" ("id", "name", "hash", "executed_at") FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-01-21 20:19:13.516146
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-01-21 20:19:13.539579
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-01-21 20:19:13.551517
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-01-21 20:19:13.591751
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-01-21 20:19:13.647181
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-01-21 20:19:13.665244
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-01-21 20:19:13.688876
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-01-21 20:19:13.729897
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-01-21 20:19:13.765725
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-01-21 20:19:13.931603
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-01-21 20:19:13.971691
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-01-21 20:19:13.990698
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-01-21 20:19:14.011861
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-01-21 20:19:14.030391
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-01-21 20:19:14.046932
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-01-21 20:19:14.083775
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-01-21 20:19:14.097155
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-01-21 20:19:14.116114
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-01-21 20:19:14.141079
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-01-21 20:19:14.156226
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-01-21 20:19:14.170177
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-01-21 20:19:14.18996
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-01-21 20:19:14.231727
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-01-21 20:19:14.266035
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-01-21 20:19:14.280679
25	custom-metadata	67eb93b7e8d401cafcdc97f9ac779e71a79bfe03	2025-01-21 20:19:14.299585
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id", "user_metadata") FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."s3_multipart_uploads" ("id", "in_progress_size", "upload_signature", "bucket_id", "key", "version", "owner_id", "created_at", "user_metadata") FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."s3_multipart_uploads_parts" ("id", "upload_id", "size", "part_number", "bucket_id", "key", "etag", "owner_id", "version", "created_at") FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY "supabase_migrations"."schema_migrations" ("version", "statements", "name") FROM stdin;
20250124200708	{"SET statement_timeout = 0","SET lock_timeout = 0","SET idle_in_transaction_session_timeout = 0","SET client_encoding = 'UTF8'","SET standard_conforming_strings = on","SELECT pg_catalog.set_config('search_path', '', false)","SET check_function_bodies = false","SET xmloption = content","SET client_min_messages = warning","SET row_security = off","CREATE EXTENSION IF NOT EXISTS \\"pgsodium\\" WITH SCHEMA \\"pgsodium\\"","COMMENT ON SCHEMA \\"public\\" IS 'standard public schema'","CREATE EXTENSION IF NOT EXISTS \\"pg_graphql\\" WITH SCHEMA \\"graphql\\"","CREATE EXTENSION IF NOT EXISTS \\"pg_stat_statements\\" WITH SCHEMA \\"extensions\\"","CREATE EXTENSION IF NOT EXISTS \\"pgcrypto\\" WITH SCHEMA \\"extensions\\"","CREATE EXTENSION IF NOT EXISTS \\"pgjwt\\" WITH SCHEMA \\"extensions\\"","CREATE EXTENSION IF NOT EXISTS \\"supabase_vault\\" WITH SCHEMA \\"vault\\"","CREATE EXTENSION IF NOT EXISTS \\"uuid-ossp\\" WITH SCHEMA \\"extensions\\"","CREATE TYPE \\"public\\".\\"user_role\\" AS ENUM (\n    'admin',\n    'moderator',\n    'user'\n)","ALTER TYPE \\"public\\".\\"user_role\\" OWNER TO \\"postgres\\"","CREATE OR REPLACE FUNCTION \\"public\\".\\"add_role_to_jwt\\"() RETURNS \\"trigger\\"\n    LANGUAGE \\"plpgsql\\" SECURITY DEFINER\n    AS $$\r\nBEGIN\r\n  NEW.claims = jsonb_set(\r\n    NEW.claims,\r\n    '{role}',\r\n    to_jsonb((SELECT role FROM auth.users WHERE id = NEW.user_id))\r\n  );\r\n  RETURN NEW;\r\nEND;\r\n$$","ALTER FUNCTION \\"public\\".\\"add_role_to_jwt\\"() OWNER TO \\"postgres\\"","CREATE OR REPLACE FUNCTION \\"public\\".\\"get_user_role\\"() RETURNS \\"jsonb\\"\n    LANGUAGE \\"plpgsql\\" SECURITY DEFINER\n    AS $$\r\nDECLARE\r\n  user_role TEXT;\r\nBEGIN\r\n  -- Get the role from the auth.users table\r\n  SELECT role INTO user_role\r\n  FROM auth.users\r\n  WHERE id = auth.uid();\r\n  \r\n  -- Return the role as a JSONB object\r\n  RETURN jsonb_build_object('role', user_role);\r\nEND;\r\n$$","ALTER FUNCTION \\"public\\".\\"get_user_role\\"() OWNER TO \\"postgres\\"","CREATE OR REPLACE FUNCTION \\"public\\".\\"get_user_role\\"(\\"user_id\\" \\"uuid\\") RETURNS \\"text\\"\n    LANGUAGE \\"sql\\" SECURITY DEFINER\n    SET \\"search_path\\" TO 'public'\n    AS $$\r\n    SELECT role::text\r\n    FROM auth.users\r\n    WHERE id = user_id\r\n    AND user_id = auth.uid();\r\n$$","ALTER FUNCTION \\"public\\".\\"get_user_role\\"(\\"user_id\\" \\"uuid\\") OWNER TO \\"postgres\\"","CREATE OR REPLACE FUNCTION \\"public\\".\\"rollback_document_version\\"(\\"p_document_type\\" \\"text\\", \\"p_version_id\\" \\"uuid\\") RETURNS \\"jsonb\\"\n    LANGUAGE \\"plpgsql\\" SECURITY DEFINER\n    SET \\"search_path\\" TO 'public'\n    AS $$\ndeclare\n    v_result jsonb;\nbegin\n    -- Set all current versions of this document type to false\n    update public.versions\n    set is_current = false\n    where document_type = p_document_type;\n\n    -- Set the specified version to current\n    update public.versions\n    set is_current = true\n    where id = p_version_id\n    returning jsonb_build_object(\n        'id', id,\n        'version_number', version_number\n    ) into v_result;\n\n    return v_result;\nend;\n$$","ALTER FUNCTION \\"public\\".\\"rollback_document_version\\"(\\"p_document_type\\" \\"text\\", \\"p_version_id\\" \\"uuid\\") OWNER TO \\"postgres\\"","CREATE OR REPLACE FUNCTION \\"public\\".\\"save_document_version\\"(\\"p_document_type\\" \\"text\\", \\"p_content\\" \\"text\\", \\"p_created_by\\" \\"uuid\\", \\"p_version_number\\" integer) RETURNS \\"jsonb\\"\n    LANGUAGE \\"plpgsql\\" SECURITY DEFINER\n    SET \\"search_path\\" TO 'public'\n    AS $$\ndeclare\n    v_result jsonb;\nbegin\n    -- Set all current versions of this document type to false\n    update public.versions\n    set is_current = false\n    where document_type = p_document_type;\n\n    -- Insert new version\n    insert into public.versions (\n        document_type,\n        content,\n        created_by,\n        version_number,\n        is_current\n    ) values (\n        p_document_type,\n        p_content,\n        p_created_by,\n        p_version_number,\n        true\n    )\n    returning jsonb_build_object(\n        'id', id,\n        'version_number', version_number\n    ) into v_result;\n\n    return v_result;\nend;\n$$","ALTER FUNCTION \\"public\\".\\"save_document_version\\"(\\"p_document_type\\" \\"text\\", \\"p_content\\" \\"text\\", \\"p_created_by\\" \\"uuid\\", \\"p_version_number\\" integer) OWNER TO \\"postgres\\"","SET default_tablespace = ''","SET default_table_access_method = \\"heap\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"matches\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"extensions\\".\\"uuid_generate_v4\\"() NOT NULL,\n    \\"created_at\\" timestamp with time zone DEFAULT \\"timezone\\"('utc'::\\"text\\", \\"now\\"()) NOT NULL,\n    \\"team1_id\\" \\"uuid\\" NOT NULL,\n    \\"team2_id\\" \\"uuid\\" NOT NULL,\n    \\"team1_score\\" integer DEFAULT 0,\n    \\"team2_score\\" integer DEFAULT 0,\n    \\"status\\" \\"text\\" DEFAULT 'upcoming'::\\"text\\",\n    \\"tournament_id\\" \\"uuid\\",\n    \\"division\\" \\"text\\" NOT NULL,\n    \\"start_time\\" timestamp with time zone NOT NULL,\n    CONSTRAINT \\"matches_status_check\\" CHECK ((\\"status\\" = ANY (ARRAY['upcoming'::\\"text\\", 'live'::\\"text\\", 'completed'::\\"text\\"]))),\n    CONSTRAINT \\"matches_teams_different\\" CHECK ((\\"team1_id\\" <> \\"team2_id\\"))\n)","ALTER TABLE \\"public\\".\\"matches\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"teams\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"extensions\\".\\"uuid_generate_v4\\"() NOT NULL,\n    \\"created_at\\" timestamp with time zone DEFAULT \\"timezone\\"('utc'::\\"text\\", \\"now\\"()) NOT NULL,\n    \\"name\\" \\"text\\" NOT NULL,\n    \\"division\\" \\"text\\" NOT NULL,\n    \\"wins\\" integer DEFAULT 0,\n    \\"losses\\" integer DEFAULT 0,\n    \\"points\\" integer DEFAULT 0,\n    \\"logo_url\\" \\"text\\"\n)","ALTER TABLE \\"public\\".\\"teams\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"players\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"extensions\\".\\"uuid_generate_v4\\"() NOT NULL,\n    \\"created_at\\" timestamp with time zone DEFAULT \\"timezone\\"('utc'::\\"text\\", \\"now\\"()) NOT NULL,\n    \\"name\\" \\"text\\" NOT NULL,\n    \\"team_id\\" \\"uuid\\" NOT NULL,\n    \\"stats\\" \\"jsonb\\" DEFAULT '{\\"goals\\": 0, \\"saves\\": 0, \\"shots\\": 0, \\"assists\\": 0}'::\\"jsonb\\"\n)","ALTER TABLE \\"public\\".\\"players\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"tournaments\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"extensions\\".\\"uuid_generate_v4\\"() NOT NULL,\n    \\"created_at\\" timestamp with time zone DEFAULT \\"timezone\\"('utc'::\\"text\\", \\"now\\"()) NOT NULL,\n    \\"name\\" \\"text\\" NOT NULL,\n    \\"start_date\\" timestamp with time zone NOT NULL,\n    \\"end_date\\" timestamp with time zone NOT NULL,\n    \\"status\\" \\"text\\" DEFAULT 'upcoming'::\\"text\\",\n    \\"prize_pool\\" numeric(10,2),\n    \\"format\\" \\"text\\" NOT NULL,\n    CONSTRAINT \\"tournaments_status_check\\" CHECK ((\\"status\\" = ANY (ARRAY['upcoming'::\\"text\\", 'active'::\\"text\\", 'completed'::\\"text\\"])))\n)","ALTER TABLE \\"public\\".\\"tournaments\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"versions\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"extensions\\".\\"uuid_generate_v4\\"() NOT NULL,\n    \\"created_at\\" timestamp with time zone DEFAULT \\"timezone\\"('utc'::\\"text\\", \\"now\\"()) NOT NULL,\n    \\"document_type\\" \\"text\\" NOT NULL,\n    \\"content\\" \\"text\\" NOT NULL,\n    \\"created_by\\" \\"uuid\\" NOT NULL,\n    \\"version_number\\" integer NOT NULL,\n    \\"is_current\\" boolean DEFAULT false NOT NULL,\n    CONSTRAINT \\"versions_document_type_check\\" CHECK ((\\"document_type\\" = ANY (ARRAY['changelog'::\\"text\\", 'broadcast_script'::\\"text\\"])))\n)","ALTER TABLE \\"public\\".\\"versions\\" OWNER TO \\"postgres\\"","CREATE OR REPLACE VIEW \\"public\\".\\"versions_with_users\\" AS\n SELECT \\"v\\".\\"id\\",\n    \\"v\\".\\"created_at\\",\n    \\"v\\".\\"document_type\\",\n    \\"v\\".\\"content\\",\n    \\"v\\".\\"created_by\\",\n    \\"v\\".\\"version_number\\",\n    \\"v\\".\\"is_current\\",\n    \\"u\\".\\"email\\" AS \\"user_email\\"\n   FROM (\\"public\\".\\"versions\\" \\"v\\"\n     LEFT JOIN \\"auth\\".\\"users\\" \\"u\\" ON ((\\"u\\".\\"id\\" = \\"v\\".\\"created_by\\")))","ALTER TABLE \\"public\\".\\"versions_with_users\\" OWNER TO \\"postgres\\"","ALTER TABLE ONLY \\"public\\".\\"matches\\"\n    ADD CONSTRAINT \\"matches_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"players\\"\n    ADD CONSTRAINT \\"players_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"teams\\"\n    ADD CONSTRAINT \\"teams_name_unique\\" UNIQUE (\\"name\\")","ALTER TABLE ONLY \\"public\\".\\"teams\\"\n    ADD CONSTRAINT \\"teams_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"tournaments\\"\n    ADD CONSTRAINT \\"tournaments_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"versions\\"\n    ADD CONSTRAINT \\"versions_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"versions\\"\n    ADD CONSTRAINT \\"fk_created_by\\" FOREIGN KEY (\\"created_by\\") REFERENCES \\"auth\\".\\"users\\"(\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"matches\\"\n    ADD CONSTRAINT \\"matches_team1_id_fkey\\" FOREIGN KEY (\\"team1_id\\") REFERENCES \\"public\\".\\"teams\\"(\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"matches\\"\n    ADD CONSTRAINT \\"matches_team2_id_fkey\\" FOREIGN KEY (\\"team2_id\\") REFERENCES \\"public\\".\\"teams\\"(\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"players\\"\n    ADD CONSTRAINT \\"players_team_id_fkey\\" FOREIGN KEY (\\"team_id\\") REFERENCES \\"public\\".\\"teams\\"(\\"id\\")","CREATE POLICY \\"Admin full access\\" ON \\"public\\".\\"matches\\" TO \\"authenticated\\" USING ((\\"auth\\".\\"role\\"() = 'admin'::\\"text\\")) WITH CHECK ((\\"auth\\".\\"role\\"() = 'admin'::\\"text\\"))","CREATE POLICY \\"Admin full access\\" ON \\"public\\".\\"players\\" TO \\"authenticated\\" USING ((\\"auth\\".\\"role\\"() = 'admin'::\\"text\\")) WITH CHECK ((\\"auth\\".\\"role\\"() = 'admin'::\\"text\\"))","CREATE POLICY \\"Admin full access\\" ON \\"public\\".\\"teams\\" TO \\"authenticated\\" USING ((\\"auth\\".\\"role\\"() = 'admin'::\\"text\\")) WITH CHECK ((\\"auth\\".\\"role\\"() = 'admin'::\\"text\\"))","CREATE POLICY \\"Admin full access\\" ON \\"public\\".\\"tournaments\\" TO \\"authenticated\\" USING ((\\"auth\\".\\"role\\"() = 'admin'::\\"text\\")) WITH CHECK ((\\"auth\\".\\"role\\"() = 'admin'::\\"text\\"))","CREATE POLICY \\"Admin full access\\" ON \\"public\\".\\"versions\\" TO \\"authenticated\\" USING ((\\"auth\\".\\"role\\"() = 'admin'::\\"text\\")) WITH CHECK ((\\"auth\\".\\"role\\"() = 'admin'::\\"text\\"))","CREATE POLICY \\"Admins have full access to versions\\" ON \\"public\\".\\"versions\\" TO \\"authenticated\\" USING (((\\"auth\\".\\"jwt\\"() ->> 'role'::\\"text\\") = 'admin'::\\"text\\")) WITH CHECK (((\\"auth\\".\\"jwt\\"() ->> 'role'::\\"text\\") = 'admin'::\\"text\\"))","CREATE POLICY \\"Allow admin access\\" ON \\"public\\".\\"teams\\" TO \\"authenticated\\" USING ((EXISTS ( SELECT 1\n   FROM \\"auth\\".\\"users\\"\n  WHERE ((\\"users\\".\\"id\\" = \\"auth\\".\\"uid\\"()) AND ((\\"users\\".\\"role\\")::\\"text\\" = 'admin'::\\"text\\")))))","CREATE POLICY \\"Allow moderator access\\" ON \\"public\\".\\"teams\\" FOR SELECT TO \\"authenticated\\" USING ((EXISTS ( SELECT 1\n   FROM \\"auth\\".\\"users\\"\n  WHERE ((\\"users\\".\\"id\\" = \\"auth\\".\\"uid\\"()) AND ((\\"users\\".\\"role\\")::\\"text\\" = ANY ((ARRAY['admin'::character varying, 'moderator'::character varying])::\\"text\\"[]))))))","CREATE POLICY \\"Moderator read access\\" ON \\"public\\".\\"matches\\" FOR SELECT TO \\"authenticated\\" USING ((\\"auth\\".\\"role\\"() = ANY (ARRAY['admin'::\\"text\\", 'moderator'::\\"text\\"])))","CREATE POLICY \\"Moderators can create versions\\" ON \\"public\\".\\"versions\\" FOR INSERT TO \\"authenticated\\" WITH CHECK (((\\"auth\\".\\"jwt\\"() ->> 'role'::\\"text\\") = ANY (ARRAY['admin'::\\"text\\", 'moderator'::\\"text\\"])))","CREATE POLICY \\"Moderators can update matches\\" ON \\"public\\".\\"matches\\" FOR UPDATE TO \\"authenticated\\" USING (((\\"auth\\".\\"jwt\\"() ->> 'role'::\\"text\\") = ANY (ARRAY['admin'::\\"text\\", 'moderator'::\\"text\\"]))) WITH CHECK (((\\"auth\\".\\"jwt\\"() ->> 'role'::\\"text\\") = ANY (ARRAY['admin'::\\"text\\", 'moderator'::\\"text\\"])))","CREATE POLICY \\"Moderators can view and create versions\\" ON \\"public\\".\\"versions\\" FOR SELECT TO \\"authenticated\\" USING (((\\"auth\\".\\"jwt\\"() ->> 'role'::\\"text\\") = ANY (ARRAY['admin'::\\"text\\", 'moderator'::\\"text\\"])))","CREATE POLICY \\"Moderators can view matches\\" ON \\"public\\".\\"matches\\" FOR SELECT TO \\"authenticated\\" USING (((\\"auth\\".\\"jwt\\"() ->> 'role'::\\"text\\") = ANY (ARRAY['admin'::\\"text\\", 'moderator'::\\"text\\"])))","CREATE POLICY \\"Players are editable by authenticated users\\" ON \\"public\\".\\"players\\" TO \\"authenticated\\" USING (true) WITH CHECK (true)","CREATE POLICY \\"Players are viewable by everyone\\" ON \\"public\\".\\"players\\" FOR SELECT USING (true)","CREATE POLICY \\"Public can view matches\\" ON \\"public\\".\\"matches\\" FOR SELECT USING (true)","CREATE POLICY \\"Public read access\\" ON \\"public\\".\\"matches\\" FOR SELECT USING (true)","CREATE POLICY \\"Teams are editable by authenticated users\\" ON \\"public\\".\\"teams\\" TO \\"authenticated\\" USING (true) WITH CHECK (true)","CREATE POLICY \\"Teams are viewable by everyone\\" ON \\"public\\".\\"teams\\" FOR SELECT USING (true)","CREATE POLICY \\"Tournaments are editable by authenticated users\\" ON \\"public\\".\\"tournaments\\" TO \\"authenticated\\" USING (true) WITH CHECK (true)","CREATE POLICY \\"Tournaments are viewable by everyone\\" ON \\"public\\".\\"tournaments\\" FOR SELECT USING (true)","CREATE POLICY \\"Versions are editable by authenticated users\\" ON \\"public\\".\\"versions\\" FOR INSERT TO \\"authenticated\\" WITH CHECK (true)","CREATE POLICY \\"Versions are updatable by authenticated users\\" ON \\"public\\".\\"versions\\" FOR UPDATE TO \\"authenticated\\" USING (true) WITH CHECK (true)","CREATE POLICY \\"Versions are viewable by authenticated users\\" ON \\"public\\".\\"versions\\" FOR SELECT TO \\"authenticated\\" USING (true)","CREATE POLICY \\"admin_access\\" ON \\"public\\".\\"teams\\" TO \\"authenticated\\" USING ((EXISTS ( SELECT 1\n   FROM \\"auth\\".\\"users\\"\n  WHERE ((\\"users\\".\\"id\\" = \\"auth\\".\\"uid\\"()) AND (\\"users\\".\\"is_admin\\" = true)))))","CREATE POLICY \\"admin_access_teams\\" ON \\"public\\".\\"teams\\" TO \\"authenticated\\" USING ((( SELECT (\\"users\\".\\"role\\")::\\"text\\" AS \\"role\\"\n   FROM \\"auth\\".\\"users\\"\n  WHERE (\\"users\\".\\"id\\" = \\"auth\\".\\"uid\\"())) = 'admin'::\\"text\\"))","ALTER TABLE \\"public\\".\\"matches\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"players\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"teams\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"tournaments\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"versions\\" ENABLE ROW LEVEL SECURITY","ALTER PUBLICATION \\"supabase_realtime\\" OWNER TO \\"postgres\\"","ALTER PUBLICATION \\"supabase_realtime\\" ADD TABLE ONLY \\"public\\".\\"matches\\"","ALTER PUBLICATION \\"supabase_realtime\\" ADD TABLE ONLY \\"public\\".\\"players\\"","ALTER PUBLICATION \\"supabase_realtime\\" ADD TABLE ONLY \\"public\\".\\"teams\\"","ALTER PUBLICATION \\"supabase_realtime\\" ADD TABLE ONLY \\"public\\".\\"tournaments\\"","ALTER PUBLICATION \\"supabase_realtime\\" ADD TABLE ONLY \\"public\\".\\"versions\\"","GRANT USAGE ON SCHEMA \\"public\\" TO \\"postgres\\"","GRANT USAGE ON SCHEMA \\"public\\" TO \\"anon\\"","GRANT USAGE ON SCHEMA \\"public\\" TO \\"authenticated\\"","GRANT USAGE ON SCHEMA \\"public\\" TO \\"service_role\\"","GRANT ALL ON FUNCTION \\"public\\".\\"add_role_to_jwt\\"() TO \\"anon\\"","GRANT ALL ON FUNCTION \\"public\\".\\"add_role_to_jwt\\"() TO \\"authenticated\\"","GRANT ALL ON FUNCTION \\"public\\".\\"add_role_to_jwt\\"() TO \\"service_role\\"","GRANT ALL ON FUNCTION \\"public\\".\\"get_user_role\\"() TO \\"anon\\"","GRANT ALL ON FUNCTION \\"public\\".\\"get_user_role\\"() TO \\"authenticated\\"","GRANT ALL ON FUNCTION \\"public\\".\\"get_user_role\\"() TO \\"service_role\\"","GRANT ALL ON FUNCTION \\"public\\".\\"get_user_role\\"(\\"user_id\\" \\"uuid\\") TO \\"anon\\"","GRANT ALL ON FUNCTION \\"public\\".\\"get_user_role\\"(\\"user_id\\" \\"uuid\\") TO \\"authenticated\\"","GRANT ALL ON FUNCTION \\"public\\".\\"get_user_role\\"(\\"user_id\\" \\"uuid\\") TO \\"service_role\\"","GRANT ALL ON FUNCTION \\"public\\".\\"rollback_document_version\\"(\\"p_document_type\\" \\"text\\", \\"p_version_id\\" \\"uuid\\") TO \\"anon\\"","GRANT ALL ON FUNCTION \\"public\\".\\"rollback_document_version\\"(\\"p_document_type\\" \\"text\\", \\"p_version_id\\" \\"uuid\\") TO \\"authenticated\\"","GRANT ALL ON FUNCTION \\"public\\".\\"rollback_document_version\\"(\\"p_document_type\\" \\"text\\", \\"p_version_id\\" \\"uuid\\") TO \\"service_role\\"","GRANT ALL ON FUNCTION \\"public\\".\\"save_document_version\\"(\\"p_document_type\\" \\"text\\", \\"p_content\\" \\"text\\", \\"p_created_by\\" \\"uuid\\", \\"p_version_number\\" integer) TO \\"anon\\"","GRANT ALL ON FUNCTION \\"public\\".\\"save_document_version\\"(\\"p_document_type\\" \\"text\\", \\"p_content\\" \\"text\\", \\"p_created_by\\" \\"uuid\\", \\"p_version_number\\" integer) TO \\"authenticated\\"","GRANT ALL ON FUNCTION \\"public\\".\\"save_document_version\\"(\\"p_document_type\\" \\"text\\", \\"p_content\\" \\"text\\", \\"p_created_by\\" \\"uuid\\", \\"p_version_number\\" integer) TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"matches\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"matches\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"matches\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"teams\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"teams\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"teams\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"players\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"players\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"players\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"tournaments\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"tournaments\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"tournaments\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"versions\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"versions\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"versions\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"versions_with_users\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"versions_with_users\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"versions_with_users\\" TO \\"service_role\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON SEQUENCES  TO \\"postgres\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON SEQUENCES  TO \\"anon\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON SEQUENCES  TO \\"authenticated\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON SEQUENCES  TO \\"service_role\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON FUNCTIONS  TO \\"postgres\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON FUNCTIONS  TO \\"anon\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON FUNCTIONS  TO \\"authenticated\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON FUNCTIONS  TO \\"service_role\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON TABLES  TO \\"postgres\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON TABLES  TO \\"anon\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON TABLES  TO \\"authenticated\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON TABLES  TO \\"service_role\\"","RESET ALL"}	remote_schema
20250124205028	{"drop policy \\"Allow moderator access\\" on \\"public\\".\\"teams\\"","drop policy \\"admin_access\\" on \\"public\\".\\"teams\\"","set check_function_bodies = off","CREATE OR REPLACE FUNCTION public.add_role_to_jwt()\n RETURNS trigger\n LANGUAGE plpgsql\n SECURITY DEFINER\nAS $function$\r\nBEGIN\r\n  NEW.claims = jsonb_set(\r\n    NEW.claims,\r\n    '{role}',\r\n    to_jsonb((SELECT role FROM auth.users WHERE id = NEW.user_id))\r\n  );\r\n  RETURN NEW;\r\nEND;\r\n$function$","CREATE OR REPLACE FUNCTION public.get_user_role()\n RETURNS jsonb\n LANGUAGE plpgsql\n SECURITY DEFINER\nAS $function$\r\nDECLARE\r\n  user_role TEXT;\r\nBEGIN\r\n  -- Get the role from the auth.users table\r\n  SELECT role INTO user_role\r\n  FROM auth.users\r\n  WHERE id = auth.uid();\r\n  \r\n  -- Return the role as a JSONB object\r\n  RETURN jsonb_build_object('role', user_role);\r\nEND;\r\n$function$","CREATE OR REPLACE FUNCTION public.get_user_role(user_id uuid)\n RETURNS text\n LANGUAGE sql\n SECURITY DEFINER\n SET search_path TO 'public'\nAS $function$\r\n    SELECT role::text\r\n    FROM auth.users\r\n    WHERE id = user_id\r\n    AND user_id = auth.uid();\r\n$function$","create policy \\"Allow moderator access\\"\non \\"public\\".\\"teams\\"\nas permissive\nfor select\nto authenticated\nusing ((EXISTS ( SELECT 1\n   FROM auth.users\n  WHERE ((users.id = auth.uid()) AND ((users.role)::text = ANY ((ARRAY['admin'::character varying, 'moderator'::character varying])::text[]))))))","create policy \\"admin_access\\"\non \\"public\\".\\"teams\\"\nas permissive\nfor all\nto authenticated\nusing (((auth.jwt() ->> 'role'::text) = 'admin'::text))"}	remote_schema
20250124205755	{"drop policy \\"Allow moderator access\\" on \\"public\\".\\"teams\\"","create policy \\"Allow moderator access\\"\non \\"public\\".\\"teams\\"\nas permissive\nfor select\nto authenticated\nusing ((EXISTS ( SELECT 1\n   FROM auth.users\n  WHERE ((users.id = auth.uid()) AND ((users.role)::text = ANY ((ARRAY['admin'::character varying, 'moderator'::character varying])::text[]))))))"}	remote_schema
\.


--
-- Data for Name: seed_files; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY "supabase_migrations"."seed_files" ("path", "hash") FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY "vault"."secrets" ("id", "name", "description", "secret", "key_id", "nonce", "created_at", "updated_at") FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 471, true);


--
-- Name: key_key_id_seq; Type: SEQUENCE SET; Schema: pgsodium; Owner: supabase_admin
--

SELECT pg_catalog.setval('"pgsodium"."key_key_id_seq"', 1, false);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('"realtime"."subscription_id_seq"', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."mfa_amr_claims"
    ADD CONSTRAINT "amr_id_pk" PRIMARY KEY ("id");


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."audit_log_entries"
    ADD CONSTRAINT "audit_log_entries_pkey" PRIMARY KEY ("id");


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."flow_state"
    ADD CONSTRAINT "flow_state_pkey" PRIMARY KEY ("id");


--
-- Name: hooks hooks_pkey; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY "auth"."hooks"
    ADD CONSTRAINT "hooks_pkey" PRIMARY KEY ("id");


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."identities"
    ADD CONSTRAINT "identities_pkey" PRIMARY KEY ("id");


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."identities"
    ADD CONSTRAINT "identities_provider_id_provider_unique" UNIQUE ("provider_id", "provider");


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."instances"
    ADD CONSTRAINT "instances_pkey" PRIMARY KEY ("id");


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."mfa_amr_claims"
    ADD CONSTRAINT "mfa_amr_claims_session_id_authentication_method_pkey" UNIQUE ("session_id", "authentication_method");


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."mfa_challenges"
    ADD CONSTRAINT "mfa_challenges_pkey" PRIMARY KEY ("id");


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."mfa_factors"
    ADD CONSTRAINT "mfa_factors_last_challenged_at_key" UNIQUE ("last_challenged_at");


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."mfa_factors"
    ADD CONSTRAINT "mfa_factors_pkey" PRIMARY KEY ("id");


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."one_time_tokens"
    ADD CONSTRAINT "one_time_tokens_pkey" PRIMARY KEY ("id");


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."refresh_tokens"
    ADD CONSTRAINT "refresh_tokens_pkey" PRIMARY KEY ("id");


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."refresh_tokens"
    ADD CONSTRAINT "refresh_tokens_token_unique" UNIQUE ("token");


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."saml_providers"
    ADD CONSTRAINT "saml_providers_entity_id_key" UNIQUE ("entity_id");


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."saml_providers"
    ADD CONSTRAINT "saml_providers_pkey" PRIMARY KEY ("id");


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."saml_relay_states"
    ADD CONSTRAINT "saml_relay_states_pkey" PRIMARY KEY ("id");


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."schema_migrations"
    ADD CONSTRAINT "schema_migrations_pkey" PRIMARY KEY ("version");


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."sessions"
    ADD CONSTRAINT "sessions_pkey" PRIMARY KEY ("id");


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."sso_domains"
    ADD CONSTRAINT "sso_domains_pkey" PRIMARY KEY ("id");


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."sso_providers"
    ADD CONSTRAINT "sso_providers_pkey" PRIMARY KEY ("id");


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."users"
    ADD CONSTRAINT "users_phone_key" UNIQUE ("phone");


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");


--
-- Name: matches matches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."matches"
    ADD CONSTRAINT "matches_pkey" PRIMARY KEY ("id");


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."players"
    ADD CONSTRAINT "players_pkey" PRIMARY KEY ("id");


--
-- Name: teams teams_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."teams"
    ADD CONSTRAINT "teams_name_unique" UNIQUE ("name");


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."teams"
    ADD CONSTRAINT "teams_pkey" PRIMARY KEY ("id");


--
-- Name: tournaments tournaments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."tournaments"
    ADD CONSTRAINT "tournaments_pkey" PRIMARY KEY ("id");


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."versions"
    ADD CONSTRAINT "versions_pkey" PRIMARY KEY ("id");


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY "realtime"."messages"
    ADD CONSTRAINT "messages_pkey" PRIMARY KEY ("id", "inserted_at");


--
-- Name: messages_2025_01_20 messages_2025_01_20_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY "realtime"."messages_2025_01_20"
    ADD CONSTRAINT "messages_2025_01_20_pkey" PRIMARY KEY ("id", "inserted_at");


--
-- Name: messages_2025_01_21 messages_2025_01_21_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY "realtime"."messages_2025_01_21"
    ADD CONSTRAINT "messages_2025_01_21_pkey" PRIMARY KEY ("id", "inserted_at");


--
-- Name: messages_2025_01_22 messages_2025_01_22_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY "realtime"."messages_2025_01_22"
    ADD CONSTRAINT "messages_2025_01_22_pkey" PRIMARY KEY ("id", "inserted_at");


--
-- Name: messages_2025_01_23 messages_2025_01_23_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY "realtime"."messages_2025_01_23"
    ADD CONSTRAINT "messages_2025_01_23_pkey" PRIMARY KEY ("id", "inserted_at");


--
-- Name: messages_2025_01_24 messages_2025_01_24_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY "realtime"."messages_2025_01_24"
    ADD CONSTRAINT "messages_2025_01_24_pkey" PRIMARY KEY ("id", "inserted_at");


--
-- Name: messages_2025_01_25 messages_2025_01_25_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY "realtime"."messages_2025_01_25"
    ADD CONSTRAINT "messages_2025_01_25_pkey" PRIMARY KEY ("id", "inserted_at");


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY "realtime"."subscription"
    ADD CONSTRAINT "pk_subscription" PRIMARY KEY ("id");


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY "realtime"."schema_migrations"
    ADD CONSTRAINT "schema_migrations_pkey" PRIMARY KEY ("version");


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY "storage"."buckets"
    ADD CONSTRAINT "buckets_pkey" PRIMARY KEY ("id");


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY "storage"."migrations"
    ADD CONSTRAINT "migrations_name_key" UNIQUE ("name");


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY "storage"."migrations"
    ADD CONSTRAINT "migrations_pkey" PRIMARY KEY ("id");


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY "storage"."objects"
    ADD CONSTRAINT "objects_pkey" PRIMARY KEY ("id");


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY "storage"."s3_multipart_uploads_parts"
    ADD CONSTRAINT "s3_multipart_uploads_parts_pkey" PRIMARY KEY ("id");


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY "storage"."s3_multipart_uploads"
    ADD CONSTRAINT "s3_multipart_uploads_pkey" PRIMARY KEY ("id");


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY "supabase_migrations"."schema_migrations"
    ADD CONSTRAINT "schema_migrations_pkey" PRIMARY KEY ("version");


--
-- Name: seed_files seed_files_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY "supabase_migrations"."seed_files"
    ADD CONSTRAINT "seed_files_pkey" PRIMARY KEY ("path");


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "audit_logs_instance_id_idx" ON "auth"."audit_log_entries" USING "btree" ("instance_id");


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "confirmation_token_idx" ON "auth"."users" USING "btree" ("confirmation_token") WHERE (("confirmation_token")::"text" !~ '^[0-9 ]*$'::"text");


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "email_change_token_current_idx" ON "auth"."users" USING "btree" ("email_change_token_current") WHERE (("email_change_token_current")::"text" !~ '^[0-9 ]*$'::"text");


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "email_change_token_new_idx" ON "auth"."users" USING "btree" ("email_change_token_new") WHERE (("email_change_token_new")::"text" !~ '^[0-9 ]*$'::"text");


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "factor_id_created_at_idx" ON "auth"."mfa_factors" USING "btree" ("user_id", "created_at");


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "flow_state_created_at_idx" ON "auth"."flow_state" USING "btree" ("created_at" DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "identities_email_idx" ON "auth"."identities" USING "btree" ("email" "text_pattern_ops");


--
-- Name: INDEX "identities_email_idx"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX "auth"."identities_email_idx" IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "identities_user_id_idx" ON "auth"."identities" USING "btree" ("user_id");


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "idx_auth_code" ON "auth"."flow_state" USING "btree" ("auth_code");


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "idx_user_id_auth_method" ON "auth"."flow_state" USING "btree" ("user_id", "authentication_method");


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "mfa_challenge_created_at_idx" ON "auth"."mfa_challenges" USING "btree" ("created_at" DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "mfa_factors_user_friendly_name_unique" ON "auth"."mfa_factors" USING "btree" ("friendly_name", "user_id") WHERE (TRIM(BOTH FROM "friendly_name") <> ''::"text");


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "mfa_factors_user_id_idx" ON "auth"."mfa_factors" USING "btree" ("user_id");


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "one_time_tokens_relates_to_hash_idx" ON "auth"."one_time_tokens" USING "hash" ("relates_to");


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "one_time_tokens_token_hash_hash_idx" ON "auth"."one_time_tokens" USING "hash" ("token_hash");


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "one_time_tokens_user_id_token_type_key" ON "auth"."one_time_tokens" USING "btree" ("user_id", "token_type");


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "reauthentication_token_idx" ON "auth"."users" USING "btree" ("reauthentication_token") WHERE (("reauthentication_token")::"text" !~ '^[0-9 ]*$'::"text");


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "recovery_token_idx" ON "auth"."users" USING "btree" ("recovery_token") WHERE (("recovery_token")::"text" !~ '^[0-9 ]*$'::"text");


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "refresh_tokens_instance_id_idx" ON "auth"."refresh_tokens" USING "btree" ("instance_id");


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "refresh_tokens_instance_id_user_id_idx" ON "auth"."refresh_tokens" USING "btree" ("instance_id", "user_id");


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "refresh_tokens_parent_idx" ON "auth"."refresh_tokens" USING "btree" ("parent");


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "refresh_tokens_session_id_revoked_idx" ON "auth"."refresh_tokens" USING "btree" ("session_id", "revoked");


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "refresh_tokens_updated_at_idx" ON "auth"."refresh_tokens" USING "btree" ("updated_at" DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "saml_providers_sso_provider_id_idx" ON "auth"."saml_providers" USING "btree" ("sso_provider_id");


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "saml_relay_states_created_at_idx" ON "auth"."saml_relay_states" USING "btree" ("created_at" DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "saml_relay_states_for_email_idx" ON "auth"."saml_relay_states" USING "btree" ("for_email");


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "saml_relay_states_sso_provider_id_idx" ON "auth"."saml_relay_states" USING "btree" ("sso_provider_id");


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "sessions_not_after_idx" ON "auth"."sessions" USING "btree" ("not_after" DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "sessions_user_id_idx" ON "auth"."sessions" USING "btree" ("user_id");


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "sso_domains_domain_idx" ON "auth"."sso_domains" USING "btree" ("lower"("domain"));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "sso_domains_sso_provider_id_idx" ON "auth"."sso_domains" USING "btree" ("sso_provider_id");


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "sso_providers_resource_id_idx" ON "auth"."sso_providers" USING "btree" ("lower"("resource_id"));


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "unique_phone_factor_per_user" ON "auth"."mfa_factors" USING "btree" ("user_id", "phone");


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "user_id_created_at_idx" ON "auth"."sessions" USING "btree" ("user_id", "created_at");


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX "users_email_partial_key" ON "auth"."users" USING "btree" ("email") WHERE ("is_sso_user" = false);


--
-- Name: INDEX "users_email_partial_key"; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX "auth"."users_email_partial_key" IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "users_instance_id_email_idx" ON "auth"."users" USING "btree" ("instance_id", "lower"(("email")::"text"));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "users_instance_id_idx" ON "auth"."users" USING "btree" ("instance_id");


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX "users_is_anonymous_idx" ON "auth"."users" USING "btree" ("is_anonymous");


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX "ix_realtime_subscription_entity" ON "realtime"."subscription" USING "btree" ("entity");


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX "subscription_subscription_id_entity_filters_key" ON "realtime"."subscription" USING "btree" ("subscription_id", "entity", "filters");


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX "bname" ON "storage"."buckets" USING "btree" ("name");


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX "bucketid_objname" ON "storage"."objects" USING "btree" ("bucket_id", "name");


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX "idx_multipart_uploads_list" ON "storage"."s3_multipart_uploads" USING "btree" ("bucket_id", "key", "created_at");


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX "idx_objects_bucket_id_name" ON "storage"."objects" USING "btree" ("bucket_id", "name" COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX "name_prefix_search" ON "storage"."objects" USING "btree" ("name" "text_pattern_ops");


--
-- Name: messages_2025_01_20_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX "realtime"."messages_pkey" ATTACH PARTITION "realtime"."messages_2025_01_20_pkey";


--
-- Name: messages_2025_01_21_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX "realtime"."messages_pkey" ATTACH PARTITION "realtime"."messages_2025_01_21_pkey";


--
-- Name: messages_2025_01_22_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX "realtime"."messages_pkey" ATTACH PARTITION "realtime"."messages_2025_01_22_pkey";


--
-- Name: messages_2025_01_23_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX "realtime"."messages_pkey" ATTACH PARTITION "realtime"."messages_2025_01_23_pkey";


--
-- Name: messages_2025_01_24_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX "realtime"."messages_pkey" ATTACH PARTITION "realtime"."messages_2025_01_24_pkey";


--
-- Name: messages_2025_01_25_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX "realtime"."messages_pkey" ATTACH PARTITION "realtime"."messages_2025_01_25_pkey";


--
-- Name: hooks add_role_to_jwt_trigger; Type: TRIGGER; Schema: auth; Owner: postgres
--

CREATE TRIGGER "add_role_to_jwt_trigger" BEFORE INSERT OR UPDATE ON "auth"."hooks" FOR EACH ROW EXECUTE FUNCTION "public"."add_role_to_jwt"();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER "tr_check_filters" BEFORE INSERT OR UPDATE ON "realtime"."subscription" FOR EACH ROW EXECUTE FUNCTION "realtime"."subscription_check_filters"();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER "update_objects_updated_at" BEFORE UPDATE ON "storage"."objects" FOR EACH ROW EXECUTE FUNCTION "storage"."update_updated_at_column"();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."identities"
    ADD CONSTRAINT "identities_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."mfa_amr_claims"
    ADD CONSTRAINT "mfa_amr_claims_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "auth"."sessions"("id") ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."mfa_challenges"
    ADD CONSTRAINT "mfa_challenges_auth_factor_id_fkey" FOREIGN KEY ("factor_id") REFERENCES "auth"."mfa_factors"("id") ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."mfa_factors"
    ADD CONSTRAINT "mfa_factors_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."one_time_tokens"
    ADD CONSTRAINT "one_time_tokens_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."refresh_tokens"
    ADD CONSTRAINT "refresh_tokens_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "auth"."sessions"("id") ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."saml_providers"
    ADD CONSTRAINT "saml_providers_sso_provider_id_fkey" FOREIGN KEY ("sso_provider_id") REFERENCES "auth"."sso_providers"("id") ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."saml_relay_states"
    ADD CONSTRAINT "saml_relay_states_flow_state_id_fkey" FOREIGN KEY ("flow_state_id") REFERENCES "auth"."flow_state"("id") ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."saml_relay_states"
    ADD CONSTRAINT "saml_relay_states_sso_provider_id_fkey" FOREIGN KEY ("sso_provider_id") REFERENCES "auth"."sso_providers"("id") ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."sessions"
    ADD CONSTRAINT "sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY "auth"."sso_domains"
    ADD CONSTRAINT "sso_domains_sso_provider_id_fkey" FOREIGN KEY ("sso_provider_id") REFERENCES "auth"."sso_providers"("id") ON DELETE CASCADE;


--
-- Name: versions fk_created_by; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."versions"
    ADD CONSTRAINT "fk_created_by" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id");


--
-- Name: matches matches_team1_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."matches"
    ADD CONSTRAINT "matches_team1_id_fkey" FOREIGN KEY ("team1_id") REFERENCES "public"."teams"("id");


--
-- Name: matches matches_team2_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."matches"
    ADD CONSTRAINT "matches_team2_id_fkey" FOREIGN KEY ("team2_id") REFERENCES "public"."teams"("id");


--
-- Name: players players_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "public"."players"
    ADD CONSTRAINT "players_team_id_fkey" FOREIGN KEY ("team_id") REFERENCES "public"."teams"("id");


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY "storage"."objects"
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY ("bucket_id") REFERENCES "storage"."buckets"("id");


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY "storage"."s3_multipart_uploads"
    ADD CONSTRAINT "s3_multipart_uploads_bucket_id_fkey" FOREIGN KEY ("bucket_id") REFERENCES "storage"."buckets"("id");


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY "storage"."s3_multipart_uploads_parts"
    ADD CONSTRAINT "s3_multipart_uploads_parts_bucket_id_fkey" FOREIGN KEY ("bucket_id") REFERENCES "storage"."buckets"("id");


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY "storage"."s3_multipart_uploads_parts"
    ADD CONSTRAINT "s3_multipart_uploads_parts_upload_id_fkey" FOREIGN KEY ("upload_id") REFERENCES "storage"."s3_multipart_uploads"("id") ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."audit_log_entries" ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."flow_state" ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."identities" ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."instances" ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."mfa_amr_claims" ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."mfa_challenges" ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."mfa_factors" ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."one_time_tokens" ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."refresh_tokens" ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."saml_providers" ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."saml_relay_states" ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."schema_migrations" ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."sessions" ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."sso_domains" ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."sso_providers" ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE "auth"."users" ENABLE ROW LEVEL SECURITY;

--
-- Name: matches Admin full access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin full access" ON "public"."matches" TO "authenticated" USING (("auth"."role"() = 'admin'::"text")) WITH CHECK (("auth"."role"() = 'admin'::"text"));


--
-- Name: players Admin full access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin full access" ON "public"."players" TO "authenticated" USING (("auth"."role"() = 'admin'::"text")) WITH CHECK (("auth"."role"() = 'admin'::"text"));


--
-- Name: teams Admin full access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin full access" ON "public"."teams" TO "authenticated" USING (("auth"."role"() = 'admin'::"text")) WITH CHECK (("auth"."role"() = 'admin'::"text"));


--
-- Name: tournaments Admin full access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin full access" ON "public"."tournaments" TO "authenticated" USING (("auth"."role"() = 'admin'::"text")) WITH CHECK (("auth"."role"() = 'admin'::"text"));


--
-- Name: versions Admin full access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin full access" ON "public"."versions" TO "authenticated" USING (("auth"."role"() = 'admin'::"text")) WITH CHECK (("auth"."role"() = 'admin'::"text"));


--
-- Name: versions Admins have full access to versions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins have full access to versions" ON "public"."versions" TO "authenticated" USING ((("auth"."jwt"() ->> 'role'::"text") = 'admin'::"text")) WITH CHECK ((("auth"."jwt"() ->> 'role'::"text") = 'admin'::"text"));


--
-- Name: teams Allow admin access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow admin access" ON "public"."teams" TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "auth"."users"
  WHERE (("users"."id" = "auth"."uid"()) AND (("users"."role")::"text" = 'admin'::"text")))));


--
-- Name: teams Allow moderator access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow moderator access" ON "public"."teams" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "auth"."users"
  WHERE (("users"."id" = "auth"."uid"()) AND (("users"."role")::"text" = ANY ((ARRAY['admin'::character varying, 'moderator'::character varying])::"text"[]))))));


--
-- Name: matches Moderator read access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Moderator read access" ON "public"."matches" FOR SELECT TO "authenticated" USING (("auth"."role"() = ANY (ARRAY['admin'::"text", 'moderator'::"text"])));


--
-- Name: versions Moderators can create versions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Moderators can create versions" ON "public"."versions" FOR INSERT TO "authenticated" WITH CHECK ((("auth"."jwt"() ->> 'role'::"text") = ANY (ARRAY['admin'::"text", 'moderator'::"text"])));


--
-- Name: matches Moderators can update matches; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Moderators can update matches" ON "public"."matches" FOR UPDATE TO "authenticated" USING ((("auth"."jwt"() ->> 'role'::"text") = ANY (ARRAY['admin'::"text", 'moderator'::"text"]))) WITH CHECK ((("auth"."jwt"() ->> 'role'::"text") = ANY (ARRAY['admin'::"text", 'moderator'::"text"])));


--
-- Name: versions Moderators can view and create versions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Moderators can view and create versions" ON "public"."versions" FOR SELECT TO "authenticated" USING ((("auth"."jwt"() ->> 'role'::"text") = ANY (ARRAY['admin'::"text", 'moderator'::"text"])));


--
-- Name: matches Moderators can view matches; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Moderators can view matches" ON "public"."matches" FOR SELECT TO "authenticated" USING ((("auth"."jwt"() ->> 'role'::"text") = ANY (ARRAY['admin'::"text", 'moderator'::"text"])));


--
-- Name: players Players are editable by authenticated users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Players are editable by authenticated users" ON "public"."players" TO "authenticated" USING (true) WITH CHECK (true);


--
-- Name: players Players are viewable by everyone; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Players are viewable by everyone" ON "public"."players" FOR SELECT USING (true);


--
-- Name: matches Public can view matches; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Public can view matches" ON "public"."matches" FOR SELECT USING (true);


--
-- Name: matches Public read access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Public read access" ON "public"."matches" FOR SELECT USING (true);


--
-- Name: teams Teams are editable by authenticated users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Teams are editable by authenticated users" ON "public"."teams" TO "authenticated" USING (true) WITH CHECK (true);


--
-- Name: teams Teams are viewable by everyone; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Teams are viewable by everyone" ON "public"."teams" FOR SELECT USING (true);


--
-- Name: tournaments Tournaments are editable by authenticated users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Tournaments are editable by authenticated users" ON "public"."tournaments" TO "authenticated" USING (true) WITH CHECK (true);


--
-- Name: tournaments Tournaments are viewable by everyone; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Tournaments are viewable by everyone" ON "public"."tournaments" FOR SELECT USING (true);


--
-- Name: versions Versions are editable by authenticated users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Versions are editable by authenticated users" ON "public"."versions" FOR INSERT TO "authenticated" WITH CHECK (true);


--
-- Name: versions Versions are updatable by authenticated users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Versions are updatable by authenticated users" ON "public"."versions" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);


--
-- Name: versions Versions are viewable by authenticated users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Versions are viewable by authenticated users" ON "public"."versions" FOR SELECT TO "authenticated" USING (true);


--
-- Name: teams admin_access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "admin_access" ON "public"."teams" TO "authenticated" USING ((("auth"."jwt"() ->> 'role'::"text") = 'admin'::"text"));


--
-- Name: teams admin_access_teams; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "admin_access_teams" ON "public"."teams" TO "authenticated" USING ((( SELECT ("users"."role")::"text" AS "role"
   FROM "auth"."users"
  WHERE ("users"."id" = "auth"."uid"())) = 'admin'::"text"));


--
-- Name: matches; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."matches" ENABLE ROW LEVEL SECURITY;

--
-- Name: players; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."players" ENABLE ROW LEVEL SECURITY;

--
-- Name: teams; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."teams" ENABLE ROW LEVEL SECURITY;

--
-- Name: tournaments; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."tournaments" ENABLE ROW LEVEL SECURITY;

--
-- Name: versions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE "public"."versions" ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE "realtime"."messages" ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE "storage"."buckets" ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE "storage"."migrations" ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE "storage"."objects" ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE "storage"."s3_multipart_uploads" ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE "storage"."s3_multipart_uploads_parts" ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION "supabase_realtime" WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: supabase_realtime matches; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."matches";


--
-- Name: supabase_realtime players; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."players";


--
-- Name: supabase_realtime teams; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."teams";


--
-- Name: supabase_realtime tournaments; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."tournaments";


--
-- Name: supabase_realtime versions; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."versions";


--
-- Name: SCHEMA "auth"; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA "auth" TO "anon";
GRANT USAGE ON SCHEMA "auth" TO "authenticated";
GRANT USAGE ON SCHEMA "auth" TO "service_role";
GRANT ALL ON SCHEMA "auth" TO "supabase_auth_admin";
GRANT ALL ON SCHEMA "auth" TO "dashboard_user";
GRANT ALL ON SCHEMA "auth" TO "postgres";


--
-- Name: SCHEMA "extensions"; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA "extensions" TO "anon";
GRANT USAGE ON SCHEMA "extensions" TO "authenticated";
GRANT USAGE ON SCHEMA "extensions" TO "service_role";
GRANT ALL ON SCHEMA "extensions" TO "dashboard_user";


--
-- Name: SCHEMA "public"; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";


--
-- Name: SCHEMA "realtime"; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA "realtime" TO "postgres";
GRANT USAGE ON SCHEMA "realtime" TO "anon";
GRANT USAGE ON SCHEMA "realtime" TO "authenticated";
GRANT USAGE ON SCHEMA "realtime" TO "service_role";
GRANT ALL ON SCHEMA "realtime" TO "supabase_realtime_admin";


--
-- Name: SCHEMA "storage"; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT ALL ON SCHEMA "storage" TO "postgres";
GRANT USAGE ON SCHEMA "storage" TO "anon";
GRANT USAGE ON SCHEMA "storage" TO "authenticated";
GRANT USAGE ON SCHEMA "storage" TO "service_role";
GRANT ALL ON SCHEMA "storage" TO "supabase_storage_admin";
GRANT ALL ON SCHEMA "storage" TO "dashboard_user";


--
-- Name: FUNCTION "check_user_role"("required_role" "text"); Type: ACL; Schema: auth; Owner: postgres
--

GRANT ALL ON FUNCTION "auth"."check_user_role"("required_role" "text") TO "authenticated";


--
-- Name: FUNCTION "check_user_role_in"("required_roles" "text"[]); Type: ACL; Schema: auth; Owner: postgres
--

GRANT ALL ON FUNCTION "auth"."check_user_role_in"("required_roles" "text"[]) TO "authenticated";


--
-- Name: FUNCTION "email"(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION "auth"."email"() TO "dashboard_user";


--
-- Name: FUNCTION "is_admin"(); Type: ACL; Schema: auth; Owner: postgres
--

GRANT ALL ON FUNCTION "auth"."is_admin"() TO "authenticated";


--
-- Name: FUNCTION "jwt"(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION "auth"."jwt"() TO "postgres";
GRANT ALL ON FUNCTION "auth"."jwt"() TO "dashboard_user";


--
-- Name: FUNCTION "role"(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION "auth"."role"() TO "dashboard_user";


--
-- Name: FUNCTION "uid"(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION "auth"."uid"() TO "dashboard_user";


--
-- Name: FUNCTION "algorithm_sign"("signables" "text", "secret" "text", "algorithm" "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."algorithm_sign"("signables" "text", "secret" "text", "algorithm" "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."algorithm_sign"("signables" "text", "secret" "text", "algorithm" "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."algorithm_sign"("signables" "text", "secret" "text", "algorithm" "text") TO "dashboard_user";


--
-- Name: FUNCTION "armor"("bytea"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."armor"("bytea") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."armor"("bytea") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."armor"("bytea") TO "dashboard_user";


--
-- Name: FUNCTION "armor"("bytea", "text"[], "text"[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."armor"("bytea", "text"[], "text"[]) FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."armor"("bytea", "text"[], "text"[]) TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."armor"("bytea", "text"[], "text"[]) TO "dashboard_user";


--
-- Name: FUNCTION "crypt"("text", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."crypt"("text", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."crypt"("text", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."crypt"("text", "text") TO "dashboard_user";


--
-- Name: FUNCTION "dearmor"("text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."dearmor"("text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."dearmor"("text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."dearmor"("text") TO "dashboard_user";


--
-- Name: FUNCTION "decrypt"("bytea", "bytea", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."decrypt"("bytea", "bytea", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."decrypt"("bytea", "bytea", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."decrypt"("bytea", "bytea", "text") TO "dashboard_user";


--
-- Name: FUNCTION "decrypt_iv"("bytea", "bytea", "bytea", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."decrypt_iv"("bytea", "bytea", "bytea", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."decrypt_iv"("bytea", "bytea", "bytea", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."decrypt_iv"("bytea", "bytea", "bytea", "text") TO "dashboard_user";


--
-- Name: FUNCTION "digest"("bytea", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."digest"("bytea", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."digest"("bytea", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."digest"("bytea", "text") TO "dashboard_user";


--
-- Name: FUNCTION "digest"("text", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."digest"("text", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."digest"("text", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."digest"("text", "text") TO "dashboard_user";


--
-- Name: FUNCTION "encrypt"("bytea", "bytea", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."encrypt"("bytea", "bytea", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."encrypt"("bytea", "bytea", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."encrypt"("bytea", "bytea", "text") TO "dashboard_user";


--
-- Name: FUNCTION "encrypt_iv"("bytea", "bytea", "bytea", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."encrypt_iv"("bytea", "bytea", "bytea", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."encrypt_iv"("bytea", "bytea", "bytea", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."encrypt_iv"("bytea", "bytea", "bytea", "text") TO "dashboard_user";


--
-- Name: FUNCTION "gen_random_bytes"(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."gen_random_bytes"(integer) FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."gen_random_bytes"(integer) TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."gen_random_bytes"(integer) TO "dashboard_user";


--
-- Name: FUNCTION "gen_random_uuid"(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."gen_random_uuid"() FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."gen_random_uuid"() TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."gen_random_uuid"() TO "dashboard_user";


--
-- Name: FUNCTION "gen_salt"("text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."gen_salt"("text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."gen_salt"("text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."gen_salt"("text") TO "dashboard_user";


--
-- Name: FUNCTION "gen_salt"("text", integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."gen_salt"("text", integer) FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."gen_salt"("text", integer) TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."gen_salt"("text", integer) TO "dashboard_user";


--
-- Name: FUNCTION "grant_pg_cron_access"(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."grant_pg_cron_access"() FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."grant_pg_cron_access"() TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."grant_pg_cron_access"() TO "dashboard_user";


--
-- Name: FUNCTION "grant_pg_graphql_access"(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION "extensions"."grant_pg_graphql_access"() TO "postgres" WITH GRANT OPTION;


--
-- Name: FUNCTION "grant_pg_net_access"(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."grant_pg_net_access"() FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."grant_pg_net_access"() TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."grant_pg_net_access"() TO "dashboard_user";


--
-- Name: FUNCTION "hmac"("bytea", "bytea", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."hmac"("bytea", "bytea", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."hmac"("bytea", "bytea", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."hmac"("bytea", "bytea", "text") TO "dashboard_user";


--
-- Name: FUNCTION "hmac"("text", "text", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."hmac"("text", "text", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."hmac"("text", "text", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."hmac"("text", "text", "text") TO "dashboard_user";


--
-- Name: FUNCTION "pg_stat_statements"("showtext" boolean, OUT "userid" "oid", OUT "dbid" "oid", OUT "toplevel" boolean, OUT "queryid" bigint, OUT "query" "text", OUT "plans" bigint, OUT "total_plan_time" double precision, OUT "min_plan_time" double precision, OUT "max_plan_time" double precision, OUT "mean_plan_time" double precision, OUT "stddev_plan_time" double precision, OUT "calls" bigint, OUT "total_exec_time" double precision, OUT "min_exec_time" double precision, OUT "max_exec_time" double precision, OUT "mean_exec_time" double precision, OUT "stddev_exec_time" double precision, OUT "rows" bigint, OUT "shared_blks_hit" bigint, OUT "shared_blks_read" bigint, OUT "shared_blks_dirtied" bigint, OUT "shared_blks_written" bigint, OUT "local_blks_hit" bigint, OUT "local_blks_read" bigint, OUT "local_blks_dirtied" bigint, OUT "local_blks_written" bigint, OUT "temp_blks_read" bigint, OUT "temp_blks_written" bigint, OUT "blk_read_time" double precision, OUT "blk_write_time" double precision, OUT "temp_blk_read_time" double precision, OUT "temp_blk_write_time" double precision, OUT "wal_records" bigint, OUT "wal_fpi" bigint, OUT "wal_bytes" numeric, OUT "jit_functions" bigint, OUT "jit_generation_time" double precision, OUT "jit_inlining_count" bigint, OUT "jit_inlining_time" double precision, OUT "jit_optimization_count" bigint, OUT "jit_optimization_time" double precision, OUT "jit_emission_count" bigint, OUT "jit_emission_time" double precision); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pg_stat_statements"("showtext" boolean, OUT "userid" "oid", OUT "dbid" "oid", OUT "toplevel" boolean, OUT "queryid" bigint, OUT "query" "text", OUT "plans" bigint, OUT "total_plan_time" double precision, OUT "min_plan_time" double precision, OUT "max_plan_time" double precision, OUT "mean_plan_time" double precision, OUT "stddev_plan_time" double precision, OUT "calls" bigint, OUT "total_exec_time" double precision, OUT "min_exec_time" double precision, OUT "max_exec_time" double precision, OUT "mean_exec_time" double precision, OUT "stddev_exec_time" double precision, OUT "rows" bigint, OUT "shared_blks_hit" bigint, OUT "shared_blks_read" bigint, OUT "shared_blks_dirtied" bigint, OUT "shared_blks_written" bigint, OUT "local_blks_hit" bigint, OUT "local_blks_read" bigint, OUT "local_blks_dirtied" bigint, OUT "local_blks_written" bigint, OUT "temp_blks_read" bigint, OUT "temp_blks_written" bigint, OUT "blk_read_time" double precision, OUT "blk_write_time" double precision, OUT "temp_blk_read_time" double precision, OUT "temp_blk_write_time" double precision, OUT "wal_records" bigint, OUT "wal_fpi" bigint, OUT "wal_bytes" numeric, OUT "jit_functions" bigint, OUT "jit_generation_time" double precision, OUT "jit_inlining_count" bigint, OUT "jit_inlining_time" double precision, OUT "jit_optimization_count" bigint, OUT "jit_optimization_time" double precision, OUT "jit_emission_count" bigint, OUT "jit_emission_time" double precision) FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pg_stat_statements"("showtext" boolean, OUT "userid" "oid", OUT "dbid" "oid", OUT "toplevel" boolean, OUT "queryid" bigint, OUT "query" "text", OUT "plans" bigint, OUT "total_plan_time" double precision, OUT "min_plan_time" double precision, OUT "max_plan_time" double precision, OUT "mean_plan_time" double precision, OUT "stddev_plan_time" double precision, OUT "calls" bigint, OUT "total_exec_time" double precision, OUT "min_exec_time" double precision, OUT "max_exec_time" double precision, OUT "mean_exec_time" double precision, OUT "stddev_exec_time" double precision, OUT "rows" bigint, OUT "shared_blks_hit" bigint, OUT "shared_blks_read" bigint, OUT "shared_blks_dirtied" bigint, OUT "shared_blks_written" bigint, OUT "local_blks_hit" bigint, OUT "local_blks_read" bigint, OUT "local_blks_dirtied" bigint, OUT "local_blks_written" bigint, OUT "temp_blks_read" bigint, OUT "temp_blks_written" bigint, OUT "blk_read_time" double precision, OUT "blk_write_time" double precision, OUT "temp_blk_read_time" double precision, OUT "temp_blk_write_time" double precision, OUT "wal_records" bigint, OUT "wal_fpi" bigint, OUT "wal_bytes" numeric, OUT "jit_functions" bigint, OUT "jit_generation_time" double precision, OUT "jit_inlining_count" bigint, OUT "jit_inlining_time" double precision, OUT "jit_optimization_count" bigint, OUT "jit_optimization_time" double precision, OUT "jit_emission_count" bigint, OUT "jit_emission_time" double precision) TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pg_stat_statements"("showtext" boolean, OUT "userid" "oid", OUT "dbid" "oid", OUT "toplevel" boolean, OUT "queryid" bigint, OUT "query" "text", OUT "plans" bigint, OUT "total_plan_time" double precision, OUT "min_plan_time" double precision, OUT "max_plan_time" double precision, OUT "mean_plan_time" double precision, OUT "stddev_plan_time" double precision, OUT "calls" bigint, OUT "total_exec_time" double precision, OUT "min_exec_time" double precision, OUT "max_exec_time" double precision, OUT "mean_exec_time" double precision, OUT "stddev_exec_time" double precision, OUT "rows" bigint, OUT "shared_blks_hit" bigint, OUT "shared_blks_read" bigint, OUT "shared_blks_dirtied" bigint, OUT "shared_blks_written" bigint, OUT "local_blks_hit" bigint, OUT "local_blks_read" bigint, OUT "local_blks_dirtied" bigint, OUT "local_blks_written" bigint, OUT "temp_blks_read" bigint, OUT "temp_blks_written" bigint, OUT "blk_read_time" double precision, OUT "blk_write_time" double precision, OUT "temp_blk_read_time" double precision, OUT "temp_blk_write_time" double precision, OUT "wal_records" bigint, OUT "wal_fpi" bigint, OUT "wal_bytes" numeric, OUT "jit_functions" bigint, OUT "jit_generation_time" double precision, OUT "jit_inlining_count" bigint, OUT "jit_inlining_time" double precision, OUT "jit_optimization_count" bigint, OUT "jit_optimization_time" double precision, OUT "jit_emission_count" bigint, OUT "jit_emission_time" double precision) TO "dashboard_user";


--
-- Name: FUNCTION "pg_stat_statements_info"(OUT "dealloc" bigint, OUT "stats_reset" timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pg_stat_statements_info"(OUT "dealloc" bigint, OUT "stats_reset" timestamp with time zone) FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pg_stat_statements_info"(OUT "dealloc" bigint, OUT "stats_reset" timestamp with time zone) TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pg_stat_statements_info"(OUT "dealloc" bigint, OUT "stats_reset" timestamp with time zone) TO "dashboard_user";


--
-- Name: FUNCTION "pg_stat_statements_reset"("userid" "oid", "dbid" "oid", "queryid" bigint); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pg_stat_statements_reset"("userid" "oid", "dbid" "oid", "queryid" bigint) FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pg_stat_statements_reset"("userid" "oid", "dbid" "oid", "queryid" bigint) TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pg_stat_statements_reset"("userid" "oid", "dbid" "oid", "queryid" bigint) TO "dashboard_user";


--
-- Name: FUNCTION "pgp_armor_headers"("text", OUT "key" "text", OUT "value" "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_armor_headers"("text", OUT "key" "text", OUT "value" "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_armor_headers"("text", OUT "key" "text", OUT "value" "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_armor_headers"("text", OUT "key" "text", OUT "value" "text") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_key_id"("bytea"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_key_id"("bytea") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_key_id"("bytea") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_key_id"("bytea") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_pub_decrypt"("bytea", "bytea"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_pub_decrypt"("bytea", "bytea") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_pub_decrypt"("bytea", "bytea") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_pub_decrypt"("bytea", "bytea") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_pub_decrypt"("bytea", "bytea", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_pub_decrypt"("bytea", "bytea", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_pub_decrypt"("bytea", "bytea", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_pub_decrypt"("bytea", "bytea", "text") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_pub_decrypt"("bytea", "bytea", "text", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_pub_decrypt"("bytea", "bytea", "text", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_pub_decrypt"("bytea", "bytea", "text", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_pub_decrypt"("bytea", "bytea", "text", "text") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_pub_decrypt_bytea"("bytea", "bytea"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_pub_decrypt_bytea"("bytea", "bytea") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_pub_decrypt_bytea"("bytea", "bytea") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_pub_decrypt_bytea"("bytea", "bytea") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_pub_decrypt_bytea"("bytea", "bytea", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_pub_decrypt_bytea"("bytea", "bytea", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_pub_decrypt_bytea"("bytea", "bytea", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_pub_decrypt_bytea"("bytea", "bytea", "text") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_pub_decrypt_bytea"("bytea", "bytea", "text", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_pub_decrypt_bytea"("bytea", "bytea", "text", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_pub_decrypt_bytea"("bytea", "bytea", "text", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_pub_decrypt_bytea"("bytea", "bytea", "text", "text") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_pub_encrypt"("text", "bytea"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_pub_encrypt"("text", "bytea") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_pub_encrypt"("text", "bytea") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_pub_encrypt"("text", "bytea") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_pub_encrypt"("text", "bytea", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_pub_encrypt"("text", "bytea", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_pub_encrypt"("text", "bytea", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_pub_encrypt"("text", "bytea", "text") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_pub_encrypt_bytea"("bytea", "bytea"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_pub_encrypt_bytea"("bytea", "bytea") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_pub_encrypt_bytea"("bytea", "bytea") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_pub_encrypt_bytea"("bytea", "bytea") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_pub_encrypt_bytea"("bytea", "bytea", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_pub_encrypt_bytea"("bytea", "bytea", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_pub_encrypt_bytea"("bytea", "bytea", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_pub_encrypt_bytea"("bytea", "bytea", "text") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_sym_decrypt"("bytea", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_sym_decrypt"("bytea", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_sym_decrypt"("bytea", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_sym_decrypt"("bytea", "text") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_sym_decrypt"("bytea", "text", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_sym_decrypt"("bytea", "text", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_sym_decrypt"("bytea", "text", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_sym_decrypt"("bytea", "text", "text") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_sym_decrypt_bytea"("bytea", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_sym_decrypt_bytea"("bytea", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_sym_decrypt_bytea"("bytea", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_sym_decrypt_bytea"("bytea", "text") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_sym_decrypt_bytea"("bytea", "text", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_sym_decrypt_bytea"("bytea", "text", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_sym_decrypt_bytea"("bytea", "text", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_sym_decrypt_bytea"("bytea", "text", "text") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_sym_encrypt"("text", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_sym_encrypt"("text", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_sym_encrypt"("text", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_sym_encrypt"("text", "text") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_sym_encrypt"("text", "text", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_sym_encrypt"("text", "text", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_sym_encrypt"("text", "text", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_sym_encrypt"("text", "text", "text") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_sym_encrypt_bytea"("bytea", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_sym_encrypt_bytea"("bytea", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_sym_encrypt_bytea"("bytea", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_sym_encrypt_bytea"("bytea", "text") TO "dashboard_user";


--
-- Name: FUNCTION "pgp_sym_encrypt_bytea"("bytea", "text", "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."pgp_sym_encrypt_bytea"("bytea", "text", "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."pgp_sym_encrypt_bytea"("bytea", "text", "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."pgp_sym_encrypt_bytea"("bytea", "text", "text") TO "dashboard_user";


--
-- Name: FUNCTION "pgrst_ddl_watch"(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION "extensions"."pgrst_ddl_watch"() TO "postgres" WITH GRANT OPTION;


--
-- Name: FUNCTION "pgrst_drop_watch"(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION "extensions"."pgrst_drop_watch"() TO "postgres" WITH GRANT OPTION;


--
-- Name: FUNCTION "set_graphql_placeholder"(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION "extensions"."set_graphql_placeholder"() TO "postgres" WITH GRANT OPTION;


--
-- Name: FUNCTION "sign"("payload" "json", "secret" "text", "algorithm" "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."sign"("payload" "json", "secret" "text", "algorithm" "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."sign"("payload" "json", "secret" "text", "algorithm" "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."sign"("payload" "json", "secret" "text", "algorithm" "text") TO "dashboard_user";


--
-- Name: FUNCTION "try_cast_double"("inp" "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."try_cast_double"("inp" "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."try_cast_double"("inp" "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."try_cast_double"("inp" "text") TO "dashboard_user";


--
-- Name: FUNCTION "url_decode"("data" "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."url_decode"("data" "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."url_decode"("data" "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."url_decode"("data" "text") TO "dashboard_user";


--
-- Name: FUNCTION "url_encode"("data" "bytea"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."url_encode"("data" "bytea") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."url_encode"("data" "bytea") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."url_encode"("data" "bytea") TO "dashboard_user";


--
-- Name: FUNCTION "uuid_generate_v1"(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."uuid_generate_v1"() FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."uuid_generate_v1"() TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."uuid_generate_v1"() TO "dashboard_user";


--
-- Name: FUNCTION "uuid_generate_v1mc"(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."uuid_generate_v1mc"() FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."uuid_generate_v1mc"() TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."uuid_generate_v1mc"() TO "dashboard_user";


--
-- Name: FUNCTION "uuid_generate_v3"("namespace" "uuid", "name" "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."uuid_generate_v3"("namespace" "uuid", "name" "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."uuid_generate_v3"("namespace" "uuid", "name" "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."uuid_generate_v3"("namespace" "uuid", "name" "text") TO "dashboard_user";


--
-- Name: FUNCTION "uuid_generate_v4"(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."uuid_generate_v4"() FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."uuid_generate_v4"() TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."uuid_generate_v4"() TO "dashboard_user";


--
-- Name: FUNCTION "uuid_generate_v5"("namespace" "uuid", "name" "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."uuid_generate_v5"("namespace" "uuid", "name" "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."uuid_generate_v5"("namespace" "uuid", "name" "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."uuid_generate_v5"("namespace" "uuid", "name" "text") TO "dashboard_user";


--
-- Name: FUNCTION "uuid_nil"(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."uuid_nil"() FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."uuid_nil"() TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."uuid_nil"() TO "dashboard_user";


--
-- Name: FUNCTION "uuid_ns_dns"(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."uuid_ns_dns"() FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."uuid_ns_dns"() TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."uuid_ns_dns"() TO "dashboard_user";


--
-- Name: FUNCTION "uuid_ns_oid"(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."uuid_ns_oid"() FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."uuid_ns_oid"() TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."uuid_ns_oid"() TO "dashboard_user";


--
-- Name: FUNCTION "uuid_ns_url"(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."uuid_ns_url"() FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."uuid_ns_url"() TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."uuid_ns_url"() TO "dashboard_user";


--
-- Name: FUNCTION "uuid_ns_x500"(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."uuid_ns_x500"() FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."uuid_ns_x500"() TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."uuid_ns_x500"() TO "dashboard_user";


--
-- Name: FUNCTION "verify"("token" "text", "secret" "text", "algorithm" "text"); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION "extensions"."verify"("token" "text", "secret" "text", "algorithm" "text") FROM "postgres";
GRANT ALL ON FUNCTION "extensions"."verify"("token" "text", "secret" "text", "algorithm" "text") TO "postgres" WITH GRANT OPTION;
GRANT ALL ON FUNCTION "extensions"."verify"("token" "text", "secret" "text", "algorithm" "text") TO "dashboard_user";


--
-- Name: FUNCTION "graphql"("operationName" "text", "query" "text", "variables" "jsonb", "extensions" "jsonb"); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION "graphql_public"."graphql"("operationName" "text", "query" "text", "variables" "jsonb", "extensions" "jsonb") TO "postgres";
GRANT ALL ON FUNCTION "graphql_public"."graphql"("operationName" "text", "query" "text", "variables" "jsonb", "extensions" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "graphql_public"."graphql"("operationName" "text", "query" "text", "variables" "jsonb", "extensions" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "graphql_public"."graphql"("operationName" "text", "query" "text", "variables" "jsonb", "extensions" "jsonb") TO "service_role";


--
-- Name: FUNCTION "get_auth"("p_usename" "text"); Type: ACL; Schema: pgbouncer; Owner: postgres
--

REVOKE ALL ON FUNCTION "pgbouncer"."get_auth"("p_usename" "text") FROM PUBLIC;
GRANT ALL ON FUNCTION "pgbouncer"."get_auth"("p_usename" "text") TO "pgbouncer";


--
-- Name: FUNCTION "crypto_aead_det_decrypt"("message" "bytea", "additional" "bytea", "key_uuid" "uuid", "nonce" "bytea"); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION "pgsodium"."crypto_aead_det_decrypt"("message" "bytea", "additional" "bytea", "key_uuid" "uuid", "nonce" "bytea") TO "service_role";


--
-- Name: FUNCTION "crypto_aead_det_encrypt"("message" "bytea", "additional" "bytea", "key_uuid" "uuid", "nonce" "bytea"); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION "pgsodium"."crypto_aead_det_encrypt"("message" "bytea", "additional" "bytea", "key_uuid" "uuid", "nonce" "bytea") TO "service_role";


--
-- Name: FUNCTION "crypto_aead_det_keygen"(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON FUNCTION "pgsodium"."crypto_aead_det_keygen"() TO "service_role";


--
-- Name: FUNCTION "add_role_to_jwt"(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."add_role_to_jwt"() TO "anon";
GRANT ALL ON FUNCTION "public"."add_role_to_jwt"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."add_role_to_jwt"() TO "service_role";


--
-- Name: FUNCTION "get_user_role"(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."get_user_role"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_user_role"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_user_role"() TO "service_role";


--
-- Name: FUNCTION "get_user_role"("user_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."get_user_role"("user_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."get_user_role"("user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_user_role"("user_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "rollback_document_version"("p_document_type" "text", "p_version_id" "uuid"); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."rollback_document_version"("p_document_type" "text", "p_version_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."rollback_document_version"("p_document_type" "text", "p_version_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."rollback_document_version"("p_document_type" "text", "p_version_id" "uuid") TO "service_role";


--
-- Name: FUNCTION "save_document_version"("p_document_type" "text", "p_content" "text", "p_created_by" "uuid", "p_version_number" integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION "public"."save_document_version"("p_document_type" "text", "p_content" "text", "p_created_by" "uuid", "p_version_number" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."save_document_version"("p_document_type" "text", "p_content" "text", "p_created_by" "uuid", "p_version_number" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."save_document_version"("p_document_type" "text", "p_content" "text", "p_created_by" "uuid", "p_version_number" integer) TO "service_role";


--
-- Name: FUNCTION "apply_rls"("wal" "jsonb", "max_record_bytes" integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION "realtime"."apply_rls"("wal" "jsonb", "max_record_bytes" integer) TO "postgres";
GRANT ALL ON FUNCTION "realtime"."apply_rls"("wal" "jsonb", "max_record_bytes" integer) TO "dashboard_user";
GRANT ALL ON FUNCTION "realtime"."apply_rls"("wal" "jsonb", "max_record_bytes" integer) TO "anon";
GRANT ALL ON FUNCTION "realtime"."apply_rls"("wal" "jsonb", "max_record_bytes" integer) TO "authenticated";
GRANT ALL ON FUNCTION "realtime"."apply_rls"("wal" "jsonb", "max_record_bytes" integer) TO "service_role";
GRANT ALL ON FUNCTION "realtime"."apply_rls"("wal" "jsonb", "max_record_bytes" integer) TO "supabase_realtime_admin";


--
-- Name: FUNCTION "broadcast_changes"("topic_name" "text", "event_name" "text", "operation" "text", "table_name" "text", "table_schema" "text", "new" "record", "old" "record", "level" "text"); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION "realtime"."broadcast_changes"("topic_name" "text", "event_name" "text", "operation" "text", "table_name" "text", "table_schema" "text", "new" "record", "old" "record", "level" "text") TO "postgres";
GRANT ALL ON FUNCTION "realtime"."broadcast_changes"("topic_name" "text", "event_name" "text", "operation" "text", "table_name" "text", "table_schema" "text", "new" "record", "old" "record", "level" "text") TO "dashboard_user";


--
-- Name: FUNCTION "build_prepared_statement_sql"("prepared_statement_name" "text", "entity" "regclass", "columns" "realtime"."wal_column"[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION "realtime"."build_prepared_statement_sql"("prepared_statement_name" "text", "entity" "regclass", "columns" "realtime"."wal_column"[]) TO "postgres";
GRANT ALL ON FUNCTION "realtime"."build_prepared_statement_sql"("prepared_statement_name" "text", "entity" "regclass", "columns" "realtime"."wal_column"[]) TO "dashboard_user";
GRANT ALL ON FUNCTION "realtime"."build_prepared_statement_sql"("prepared_statement_name" "text", "entity" "regclass", "columns" "realtime"."wal_column"[]) TO "anon";
GRANT ALL ON FUNCTION "realtime"."build_prepared_statement_sql"("prepared_statement_name" "text", "entity" "regclass", "columns" "realtime"."wal_column"[]) TO "authenticated";
GRANT ALL ON FUNCTION "realtime"."build_prepared_statement_sql"("prepared_statement_name" "text", "entity" "regclass", "columns" "realtime"."wal_column"[]) TO "service_role";
GRANT ALL ON FUNCTION "realtime"."build_prepared_statement_sql"("prepared_statement_name" "text", "entity" "regclass", "columns" "realtime"."wal_column"[]) TO "supabase_realtime_admin";


--
-- Name: FUNCTION "cast"("val" "text", "type_" "regtype"); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION "realtime"."cast"("val" "text", "type_" "regtype") TO "postgres";
GRANT ALL ON FUNCTION "realtime"."cast"("val" "text", "type_" "regtype") TO "dashboard_user";
GRANT ALL ON FUNCTION "realtime"."cast"("val" "text", "type_" "regtype") TO "anon";
GRANT ALL ON FUNCTION "realtime"."cast"("val" "text", "type_" "regtype") TO "authenticated";
GRANT ALL ON FUNCTION "realtime"."cast"("val" "text", "type_" "regtype") TO "service_role";
GRANT ALL ON FUNCTION "realtime"."cast"("val" "text", "type_" "regtype") TO "supabase_realtime_admin";


--
-- Name: FUNCTION "check_equality_op"("op" "realtime"."equality_op", "type_" "regtype", "val_1" "text", "val_2" "text"); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION "realtime"."check_equality_op"("op" "realtime"."equality_op", "type_" "regtype", "val_1" "text", "val_2" "text") TO "postgres";
GRANT ALL ON FUNCTION "realtime"."check_equality_op"("op" "realtime"."equality_op", "type_" "regtype", "val_1" "text", "val_2" "text") TO "dashboard_user";
GRANT ALL ON FUNCTION "realtime"."check_equality_op"("op" "realtime"."equality_op", "type_" "regtype", "val_1" "text", "val_2" "text") TO "anon";
GRANT ALL ON FUNCTION "realtime"."check_equality_op"("op" "realtime"."equality_op", "type_" "regtype", "val_1" "text", "val_2" "text") TO "authenticated";
GRANT ALL ON FUNCTION "realtime"."check_equality_op"("op" "realtime"."equality_op", "type_" "regtype", "val_1" "text", "val_2" "text") TO "service_role";
GRANT ALL ON FUNCTION "realtime"."check_equality_op"("op" "realtime"."equality_op", "type_" "regtype", "val_1" "text", "val_2" "text") TO "supabase_realtime_admin";


--
-- Name: FUNCTION "is_visible_through_filters"("columns" "realtime"."wal_column"[], "filters" "realtime"."user_defined_filter"[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION "realtime"."is_visible_through_filters"("columns" "realtime"."wal_column"[], "filters" "realtime"."user_defined_filter"[]) TO "postgres";
GRANT ALL ON FUNCTION "realtime"."is_visible_through_filters"("columns" "realtime"."wal_column"[], "filters" "realtime"."user_defined_filter"[]) TO "dashboard_user";
GRANT ALL ON FUNCTION "realtime"."is_visible_through_filters"("columns" "realtime"."wal_column"[], "filters" "realtime"."user_defined_filter"[]) TO "anon";
GRANT ALL ON FUNCTION "realtime"."is_visible_through_filters"("columns" "realtime"."wal_column"[], "filters" "realtime"."user_defined_filter"[]) TO "authenticated";
GRANT ALL ON FUNCTION "realtime"."is_visible_through_filters"("columns" "realtime"."wal_column"[], "filters" "realtime"."user_defined_filter"[]) TO "service_role";
GRANT ALL ON FUNCTION "realtime"."is_visible_through_filters"("columns" "realtime"."wal_column"[], "filters" "realtime"."user_defined_filter"[]) TO "supabase_realtime_admin";


--
-- Name: FUNCTION "list_changes"("publication" "name", "slot_name" "name", "max_changes" integer, "max_record_bytes" integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION "realtime"."list_changes"("publication" "name", "slot_name" "name", "max_changes" integer, "max_record_bytes" integer) TO "postgres";
GRANT ALL ON FUNCTION "realtime"."list_changes"("publication" "name", "slot_name" "name", "max_changes" integer, "max_record_bytes" integer) TO "dashboard_user";
GRANT ALL ON FUNCTION "realtime"."list_changes"("publication" "name", "slot_name" "name", "max_changes" integer, "max_record_bytes" integer) TO "anon";
GRANT ALL ON FUNCTION "realtime"."list_changes"("publication" "name", "slot_name" "name", "max_changes" integer, "max_record_bytes" integer) TO "authenticated";
GRANT ALL ON FUNCTION "realtime"."list_changes"("publication" "name", "slot_name" "name", "max_changes" integer, "max_record_bytes" integer) TO "service_role";
GRANT ALL ON FUNCTION "realtime"."list_changes"("publication" "name", "slot_name" "name", "max_changes" integer, "max_record_bytes" integer) TO "supabase_realtime_admin";


--
-- Name: FUNCTION "quote_wal2json"("entity" "regclass"); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION "realtime"."quote_wal2json"("entity" "regclass") TO "postgres";
GRANT ALL ON FUNCTION "realtime"."quote_wal2json"("entity" "regclass") TO "dashboard_user";
GRANT ALL ON FUNCTION "realtime"."quote_wal2json"("entity" "regclass") TO "anon";
GRANT ALL ON FUNCTION "realtime"."quote_wal2json"("entity" "regclass") TO "authenticated";
GRANT ALL ON FUNCTION "realtime"."quote_wal2json"("entity" "regclass") TO "service_role";
GRANT ALL ON FUNCTION "realtime"."quote_wal2json"("entity" "regclass") TO "supabase_realtime_admin";


--
-- Name: FUNCTION "send"("payload" "jsonb", "event" "text", "topic" "text", "private" boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION "realtime"."send"("payload" "jsonb", "event" "text", "topic" "text", "private" boolean) TO "postgres";
GRANT ALL ON FUNCTION "realtime"."send"("payload" "jsonb", "event" "text", "topic" "text", "private" boolean) TO "dashboard_user";


--
-- Name: FUNCTION "subscription_check_filters"(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION "realtime"."subscription_check_filters"() TO "postgres";
GRANT ALL ON FUNCTION "realtime"."subscription_check_filters"() TO "dashboard_user";
GRANT ALL ON FUNCTION "realtime"."subscription_check_filters"() TO "anon";
GRANT ALL ON FUNCTION "realtime"."subscription_check_filters"() TO "authenticated";
GRANT ALL ON FUNCTION "realtime"."subscription_check_filters"() TO "service_role";
GRANT ALL ON FUNCTION "realtime"."subscription_check_filters"() TO "supabase_realtime_admin";


--
-- Name: FUNCTION "to_regrole"("role_name" "text"); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION "realtime"."to_regrole"("role_name" "text") TO "postgres";
GRANT ALL ON FUNCTION "realtime"."to_regrole"("role_name" "text") TO "dashboard_user";
GRANT ALL ON FUNCTION "realtime"."to_regrole"("role_name" "text") TO "anon";
GRANT ALL ON FUNCTION "realtime"."to_regrole"("role_name" "text") TO "authenticated";
GRANT ALL ON FUNCTION "realtime"."to_regrole"("role_name" "text") TO "service_role";
GRANT ALL ON FUNCTION "realtime"."to_regrole"("role_name" "text") TO "supabase_realtime_admin";


--
-- Name: FUNCTION "topic"(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION "realtime"."topic"() TO "postgres";
GRANT ALL ON FUNCTION "realtime"."topic"() TO "dashboard_user";


--
-- Name: TABLE "audit_log_entries"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."audit_log_entries" TO "dashboard_user";
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."audit_log_entries" TO "postgres";
GRANT SELECT ON TABLE "auth"."audit_log_entries" TO "postgres" WITH GRANT OPTION;


--
-- Name: TABLE "flow_state"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."flow_state" TO "postgres";
GRANT SELECT ON TABLE "auth"."flow_state" TO "postgres" WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."flow_state" TO "dashboard_user";


--
-- Name: TABLE "identities"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."identities" TO "postgres";
GRANT SELECT ON TABLE "auth"."identities" TO "postgres" WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."identities" TO "dashboard_user";


--
-- Name: TABLE "instances"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."instances" TO "dashboard_user";
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."instances" TO "postgres";
GRANT SELECT ON TABLE "auth"."instances" TO "postgres" WITH GRANT OPTION;


--
-- Name: TABLE "mfa_amr_claims"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."mfa_amr_claims" TO "postgres";
GRANT SELECT ON TABLE "auth"."mfa_amr_claims" TO "postgres" WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."mfa_amr_claims" TO "dashboard_user";


--
-- Name: TABLE "mfa_challenges"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."mfa_challenges" TO "postgres";
GRANT SELECT ON TABLE "auth"."mfa_challenges" TO "postgres" WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."mfa_challenges" TO "dashboard_user";


--
-- Name: TABLE "mfa_factors"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."mfa_factors" TO "postgres";
GRANT SELECT ON TABLE "auth"."mfa_factors" TO "postgres" WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."mfa_factors" TO "dashboard_user";


--
-- Name: TABLE "one_time_tokens"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."one_time_tokens" TO "postgres";
GRANT SELECT ON TABLE "auth"."one_time_tokens" TO "postgres" WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."one_time_tokens" TO "dashboard_user";


--
-- Name: TABLE "refresh_tokens"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."refresh_tokens" TO "dashboard_user";
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."refresh_tokens" TO "postgres";
GRANT SELECT ON TABLE "auth"."refresh_tokens" TO "postgres" WITH GRANT OPTION;


--
-- Name: SEQUENCE "refresh_tokens_id_seq"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE "auth"."refresh_tokens_id_seq" TO "dashboard_user";
GRANT ALL ON SEQUENCE "auth"."refresh_tokens_id_seq" TO "postgres";


--
-- Name: TABLE "saml_providers"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."saml_providers" TO "postgres";
GRANT SELECT ON TABLE "auth"."saml_providers" TO "postgres" WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."saml_providers" TO "dashboard_user";


--
-- Name: TABLE "saml_relay_states"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."saml_relay_states" TO "postgres";
GRANT SELECT ON TABLE "auth"."saml_relay_states" TO "postgres" WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."saml_relay_states" TO "dashboard_user";


--
-- Name: TABLE "schema_migrations"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."schema_migrations" TO "dashboard_user";
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."schema_migrations" TO "postgres";
GRANT SELECT ON TABLE "auth"."schema_migrations" TO "postgres" WITH GRANT OPTION;


--
-- Name: TABLE "users"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."users" TO "dashboard_user";
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."users" TO "postgres";
GRANT SELECT ON TABLE "auth"."users" TO "postgres" WITH GRANT OPTION;


--
-- Name: TABLE "matches"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."matches" TO "anon";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."matches" TO "authenticated";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."matches" TO "service_role";


--
-- Name: TABLE "teams"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."teams" TO "anon";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."teams" TO "authenticated";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."teams" TO "service_role";


--
-- Name: TABLE "secure_matches"; Type: ACL; Schema: auth; Owner: postgres
--

GRANT SELECT ON TABLE "auth"."secure_matches" TO "authenticated";


--
-- Name: TABLE "sessions"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."sessions" TO "postgres";
GRANT SELECT ON TABLE "auth"."sessions" TO "postgres" WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."sessions" TO "dashboard_user";


--
-- Name: TABLE "sso_domains"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."sso_domains" TO "postgres";
GRANT SELECT ON TABLE "auth"."sso_domains" TO "postgres" WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."sso_domains" TO "dashboard_user";


--
-- Name: TABLE "sso_providers"; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."sso_providers" TO "postgres";
GRANT SELECT ON TABLE "auth"."sso_providers" TO "postgres" WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "auth"."sso_providers" TO "dashboard_user";


--
-- Name: TABLE "pg_stat_statements"; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "extensions"."pg_stat_statements" FROM "postgres";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "extensions"."pg_stat_statements" TO "postgres" WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "extensions"."pg_stat_statements" TO "dashboard_user";


--
-- Name: TABLE "pg_stat_statements_info"; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "extensions"."pg_stat_statements_info" FROM "postgres";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "extensions"."pg_stat_statements_info" TO "postgres" WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "extensions"."pg_stat_statements_info" TO "dashboard_user";


--
-- Name: TABLE "decrypted_key"; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "pgsodium"."decrypted_key" TO "pgsodium_keyholder";


--
-- Name: TABLE "masking_rule"; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "pgsodium"."masking_rule" TO "pgsodium_keyholder";


--
-- Name: TABLE "mask_columns"; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "pgsodium"."mask_columns" TO "pgsodium_keyholder";


--
-- Name: TABLE "players"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."players" TO "anon";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."players" TO "authenticated";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."players" TO "service_role";


--
-- Name: TABLE "tournaments"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."tournaments" TO "anon";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."tournaments" TO "authenticated";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."tournaments" TO "service_role";


--
-- Name: TABLE "versions"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."versions" TO "anon";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."versions" TO "authenticated";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."versions" TO "service_role";


--
-- Name: TABLE "versions_with_users"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."versions_with_users" TO "anon";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."versions_with_users" TO "authenticated";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "public"."versions_with_users" TO "service_role";


--
-- Name: TABLE "messages"; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."messages" TO "postgres";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."messages" TO "dashboard_user";
GRANT SELECT,INSERT,UPDATE ON TABLE "realtime"."messages" TO "anon";
GRANT SELECT,INSERT,UPDATE ON TABLE "realtime"."messages" TO "authenticated";
GRANT SELECT,INSERT,UPDATE ON TABLE "realtime"."messages" TO "service_role";


--
-- Name: TABLE "messages_2025_01_20"; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."messages_2025_01_20" TO "postgres";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."messages_2025_01_20" TO "dashboard_user";


--
-- Name: TABLE "messages_2025_01_21"; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."messages_2025_01_21" TO "postgres";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."messages_2025_01_21" TO "dashboard_user";


--
-- Name: TABLE "messages_2025_01_22"; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."messages_2025_01_22" TO "postgres";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."messages_2025_01_22" TO "dashboard_user";


--
-- Name: TABLE "messages_2025_01_23"; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."messages_2025_01_23" TO "postgres";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."messages_2025_01_23" TO "dashboard_user";


--
-- Name: TABLE "messages_2025_01_24"; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."messages_2025_01_24" TO "postgres";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."messages_2025_01_24" TO "dashboard_user";


--
-- Name: TABLE "messages_2025_01_25"; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."messages_2025_01_25" TO "postgres";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."messages_2025_01_25" TO "dashboard_user";


--
-- Name: TABLE "schema_migrations"; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."schema_migrations" TO "postgres";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."schema_migrations" TO "dashboard_user";
GRANT SELECT ON TABLE "realtime"."schema_migrations" TO "anon";
GRANT SELECT ON TABLE "realtime"."schema_migrations" TO "authenticated";
GRANT SELECT ON TABLE "realtime"."schema_migrations" TO "service_role";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."schema_migrations" TO "supabase_realtime_admin";


--
-- Name: TABLE "subscription"; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."subscription" TO "postgres";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."subscription" TO "dashboard_user";
GRANT SELECT ON TABLE "realtime"."subscription" TO "anon";
GRANT SELECT ON TABLE "realtime"."subscription" TO "authenticated";
GRANT SELECT ON TABLE "realtime"."subscription" TO "service_role";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "realtime"."subscription" TO "supabase_realtime_admin";


--
-- Name: SEQUENCE "subscription_id_seq"; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE "realtime"."subscription_id_seq" TO "postgres";
GRANT ALL ON SEQUENCE "realtime"."subscription_id_seq" TO "dashboard_user";
GRANT USAGE ON SEQUENCE "realtime"."subscription_id_seq" TO "anon";
GRANT USAGE ON SEQUENCE "realtime"."subscription_id_seq" TO "authenticated";
GRANT USAGE ON SEQUENCE "realtime"."subscription_id_seq" TO "service_role";
GRANT ALL ON SEQUENCE "realtime"."subscription_id_seq" TO "supabase_realtime_admin";


--
-- Name: TABLE "buckets"; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "storage"."buckets" TO "anon";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "storage"."buckets" TO "authenticated";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "storage"."buckets" TO "service_role";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "storage"."buckets" TO "postgres";


--
-- Name: TABLE "migrations"; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "storage"."migrations" TO "anon";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "storage"."migrations" TO "authenticated";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "storage"."migrations" TO "service_role";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "storage"."migrations" TO "postgres";


--
-- Name: TABLE "objects"; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "storage"."objects" TO "anon";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "storage"."objects" TO "authenticated";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "storage"."objects" TO "service_role";
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "storage"."objects" TO "postgres";


--
-- Name: TABLE "s3_multipart_uploads"; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "storage"."s3_multipart_uploads" TO "service_role";
GRANT SELECT ON TABLE "storage"."s3_multipart_uploads" TO "authenticated";
GRANT SELECT ON TABLE "storage"."s3_multipart_uploads" TO "anon";


--
-- Name: TABLE "s3_multipart_uploads_parts"; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE "storage"."s3_multipart_uploads_parts" TO "service_role";
GRANT SELECT ON TABLE "storage"."s3_multipart_uploads_parts" TO "authenticated";
GRANT SELECT ON TABLE "storage"."s3_multipart_uploads_parts" TO "anon";


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT ALL ON SEQUENCES TO "dashboard_user";


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT ALL ON FUNCTIONS TO "dashboard_user";


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "dashboard_user";


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "extensions" GRANT ALL ON SEQUENCES TO "postgres" WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "extensions" GRANT ALL ON FUNCTIONS TO "postgres" WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "extensions" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "postgres" WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql" GRANT ALL ON SEQUENCES TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql" GRANT ALL ON FUNCTIONS TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql_public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql_public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql_public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql_public" GRANT ALL ON SEQUENCES TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql_public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql_public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql_public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql_public" GRANT ALL ON FUNCTIONS TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql_public" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql_public" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql_public" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "graphql_public" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "pgsodium" GRANT ALL ON SEQUENCES TO "pgsodium_keyholder";


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "pgsodium" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "pgsodium_keyholder";


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "pgsodium_masks" GRANT ALL ON SEQUENCES TO "pgsodium_keyiduser";


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "pgsodium_masks" GRANT ALL ON FUNCTIONS TO "pgsodium_keyiduser";


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "pgsodium_masks" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "pgsodium_keyiduser";


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "public" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "realtime" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "realtime" GRANT ALL ON SEQUENCES TO "dashboard_user";


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "realtime" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "realtime" GRANT ALL ON FUNCTIONS TO "dashboard_user";


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "realtime" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_admin" IN SCHEMA "realtime" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "dashboard_user";


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON SEQUENCES TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON FUNCTIONS TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO "service_role";


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER "issue_graphql_placeholder" ON "sql_drop"
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION "extensions"."set_graphql_placeholder"();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER "issue_pg_cron_access" ON "ddl_command_end"
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION "extensions"."grant_pg_cron_access"();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER "issue_pg_graphql_access" ON "ddl_command_end"
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION "extensions"."grant_pg_graphql_access"();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER "issue_pg_net_access" ON "ddl_command_end"
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION "extensions"."grant_pg_net_access"();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO postgres;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER "pgrst_ddl_watch" ON "ddl_command_end"
   EXECUTE FUNCTION "extensions"."pgrst_ddl_watch"();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER "pgrst_drop_watch" ON "sql_drop"
   EXECUTE FUNCTION "extensions"."pgrst_drop_watch"();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

