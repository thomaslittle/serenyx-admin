-- Create roles if they don't exist
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'admin') THEN
    CREATE ROLE admin NOINHERIT;
  END IF;
END
$$;

-- Create role and permission types
CREATE TYPE app_role AS ENUM (
  'admin',
  'league_commissioner',
  'deputy_commissioner',
  'secretary',
  'treasurer',
  'match_commissioner',
  'team_manager',
  'player',
  'authenticated'
);

CREATE TYPE app_permission AS ENUM (
  'users.manage',
  'roles.manage',
  'matches.manage',
  'teams.manage',
  'players.manage',
  'finance.manage',
  'reports.view',
  'reports.create'
);

-- Create tables for roles and permissions
CREATE TABLE IF NOT EXISTS user_roles (
  user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  role app_role NOT NULL DEFAULT 'authenticated',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS role_permissions (
  role app_role NOT NULL,
  permission app_permission NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (role, permission)
);

-- Enable RLS
ALTER TABLE user_roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE role_permissions ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
CREATE POLICY "Enable read access for authenticated users"
  ON user_roles FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Enable read access for authenticated users"
  ON role_permissions FOR SELECT
  TO authenticated
  USING (true);

-- Insert default role permissions
INSERT INTO role_permissions (role, permission) VALUES
  -- Admin has all permissions
  ('admin', 'users.manage'),
  ('admin', 'roles.manage'),
  ('admin', 'matches.manage'),
  ('admin', 'teams.manage'),
  ('admin', 'players.manage'),
  ('admin', 'finance.manage'),
  ('admin', 'reports.view'),
  ('admin', 'reports.create'),
  
  -- League Commissioner has all permissions except finance
  ('league_commissioner', 'users.manage'),
  ('league_commissioner', 'roles.manage'),
  ('league_commissioner', 'matches.manage'),
  ('league_commissioner', 'teams.manage'),
  ('league_commissioner', 'players.manage'),
  ('league_commissioner', 'reports.view'),
  ('league_commissioner', 'reports.create'),
  
  -- Deputy Commissioner has most permissions
  ('deputy_commissioner', 'users.manage'),
  ('deputy_commissioner', 'roles.manage'),
  ('deputy_commissioner', 'matches.manage'),
  ('deputy_commissioner', 'teams.manage'),
  ('deputy_commissioner', 'players.manage'),
  ('deputy_commissioner', 'reports.view'),
  ('deputy_commissioner', 'reports.create'),
  
  -- Secretary has administrative permissions
  ('secretary', 'matches.manage'),
  ('secretary', 'teams.manage'),
  ('secretary', 'players.manage'),
  ('secretary', 'reports.view'),
  ('secretary', 'reports.create'),
  
  -- Treasurer has finance permissions
  ('treasurer', 'finance.manage'),
  ('treasurer', 'reports.view'),
  ('treasurer', 'reports.create'),
  
  -- Match Commissioner has match-related permissions
  ('match_commissioner', 'matches.manage'),
  ('match_commissioner', 'reports.view'),
  ('match_commissioner', 'reports.create'),
  
  -- Team Manager has team-related permissions
  ('team_manager', 'teams.manage'),
  ('team_manager', 'players.manage'),
  ('team_manager', 'reports.view'),
  
  -- Player has minimal permissions
  ('player', 'reports.view'),
  
  -- Authenticated users have basic access
  ('authenticated', 'reports.view');

-- Grant necessary permissions
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT ALL ON user_roles TO authenticated;
GRANT ALL ON role_permissions TO authenticated;
GRANT USAGE ON TYPE app_role TO authenticated;
GRANT USAGE ON TYPE app_permission TO authenticated;

-- Grant necessary permissions to roles
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO admin;
GRANT USAGE ON SCHEMA auth TO supabase_auth_admin;
GRANT USAGE ON SCHEMA public TO supabase_auth_admin;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA public TO admin;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO admin;

-- Enable RLS
ALTER TABLE public.matches ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.teams ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.versions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.role_permissions ENABLE ROW LEVEL SECURITY;

-- Create basic RLS policies
CREATE POLICY "Enable read access for authenticated users" ON public.matches
    FOR SELECT TO authenticated USING (true);

CREATE POLICY "Enable read access for authenticated users" ON public.teams
    FOR SELECT TO authenticated USING (true);

CREATE POLICY "Enable read access for authenticated users" ON public.versions
    FOR SELECT TO authenticated USING (true);

-- Create admin RLS policies
CREATE POLICY "Enable full access for admin users" ON public.matches
    FOR ALL TO authenticated 
    USING (
        (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin' OR
        EXISTS (
            SELECT 1 FROM public.user_roles 
            WHERE user_id = auth.uid() AND role = 'admin'
        )
    );

CREATE POLICY "Enable full access for admin users" ON public.teams
    FOR ALL TO authenticated 
    USING (
        (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin' OR
        EXISTS (
            SELECT 1 FROM public.user_roles 
            WHERE user_id = auth.uid() AND role = 'admin'
        )
    );

CREATE POLICY "Enable full access for admin users" ON public.versions
    FOR ALL TO authenticated 
    USING (
        (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin' OR
        EXISTS (
            SELECT 1 FROM public.user_roles 
            WHERE user_id = auth.uid() AND role = 'admin'
        )
    );

-- Create logging function
CREATE OR REPLACE FUNCTION auth.log_debug(log_message text)
RETURNS void AS $$
BEGIN
  RAISE NOTICE '%', log_message;
END;
$$ LANGUAGE plpgsql;

-- Create function to modify JWT claims
CREATE OR REPLACE FUNCTION public.custom_access_token_hook(event jsonb)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = auth, public
AS $$
DECLARE
  _user auth.users;
  user_role text;
BEGIN
  -- Get the user
  SELECT * FROM auth.users INTO _user WHERE id = auth.uid();
  
  -- Log user metadata
  PERFORM auth.log_debug('User metadata: ' || _user.raw_app_meta_data::text);
  
  -- Get user role
  user_role := COALESCE(_user.raw_app_meta_data->>'role', 'authenticated');
  PERFORM auth.log_debug('User role: ' || user_role);

  -- Add our claims to the event
  event := event || jsonb_build_object(
    'role', user_role,
    'app_metadata', _user.raw_app_meta_data
  );
  
  -- Log final JWT claims
  PERFORM auth.log_debug('JWT claims: ' || event::text);

  RETURN event;
END;
$$;

-- Grant execute permission on the hook function
GRANT EXECUTE ON FUNCTION public.custom_access_token_hook TO supabase_auth_admin;
REVOKE EXECUTE ON FUNCTION public.custom_access_token_hook FROM authenticated, anon, public;
GRANT EXECUTE ON FUNCTION auth.log_debug TO supabase_auth_admin;

-- Create function to set user role
CREATE OR REPLACE FUNCTION set_role(input_user_id uuid, input_role text)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  updated_metadata jsonb;
BEGIN
  -- Update the user's app_metadata to include the role
  UPDATE auth.users 
  SET raw_app_meta_data = 
    CASE 
      WHEN raw_app_meta_data IS NULL THEN 
        jsonb_build_object('role', input_role)
      ELSE 
        raw_app_meta_data || jsonb_build_object('role', input_role)
    END
  WHERE id = input_user_id
  RETURNING raw_app_meta_data INTO updated_metadata;

  -- Insert or update the role in user_roles table
  INSERT INTO public.user_roles (user_id, role)
  VALUES (input_user_id, input_role::app_role)
  ON CONFLICT (user_id, role) 
  DO NOTHING;

  -- Log the update
  PERFORM auth.log_debug('Updated user ' || input_user_id || ' role to ' || input_role);
  PERFORM auth.log_debug('New metadata: ' || updated_metadata::text);
END;
$$;

-- Grant necessary permissions
grant usage on schema public to authenticated;
grant usage on schema public to anon;
grant usage on schema public to service_role;

grant select on public.user_roles to authenticated;
grant select on public.role_permissions to authenticated;

-- Grant execute permission on functions
GRANT EXECUTE ON FUNCTION set_role TO authenticated;
GRANT EXECUTE ON FUNCTION set_role TO service_role;
GRANT EXECUTE ON FUNCTION set_role TO anon;

-- Grant insert permission on user_roles
GRANT INSERT ON public.user_roles TO authenticated;
GRANT INSERT ON public.user_roles TO service_role;

-- Grant update permission on auth.users
GRANT UPDATE ON auth.users TO authenticated;
GRANT UPDATE ON auth.users TO service_role;

-- Create RLS policies for user_roles
create policy "Users can read their own role"
  on public.user_roles for select
  to authenticated
  using (auth.uid() = user_id);

create policy "Users can read role permissions"
  on public.role_permissions for select
  to authenticated
  using (true);

-- Add insert policy for user_roles
create policy "Allow insert into user_roles"
  on public.user_roles for insert
  to authenticated
  with check (true);

-- Add update policy for user_roles
create policy "Allow update of user_roles"
  on public.user_roles for update
  to authenticated
  using (auth.uid() = user_id);

-- Add service role policies
create policy "Service role can manage user_roles"
  on public.user_roles
  for all
  to service_role
  using (true)
  with check (true);

-- Function to get all users with their metadata
CREATE OR REPLACE FUNCTION get_all_users()
RETURNS TABLE (
  id uuid,
  email text,
  last_sign_in_at timestamptz,
  raw_app_meta_data jsonb
) SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    au.id,
    au.email,
    au.last_sign_in_at,
    au.raw_app_meta_data
  FROM auth.users au;
END;
$$;

-- Grant execute permission on the function
GRANT EXECUTE ON FUNCTION get_all_users TO authenticated;

-- Create a view for user management
CREATE OR REPLACE VIEW user_management AS
SELECT 
    au.id,
    au.email,
    au.last_sign_in_at,
    au.raw_app_meta_data,
    COALESCE(ur.role, 'authenticated'::app_role) as role
FROM auth.users au
LEFT JOIN user_roles ur ON au.id = ur.user_id;

-- Grant access to the view
GRANT SELECT ON user_management TO authenticated;
GRANT SELECT ON user_management TO service_role;

-- Create policy for admin users to view all users
CREATE POLICY "Enable full access for admin users" ON auth.users
    FOR ALL TO authenticated 
    USING (
        (auth.jwt() -> 'app_metadata' ->> 'role') IN ('admin', 'league_commissioner', 'deputy_commissioner') OR
        EXISTS (
            SELECT 1 FROM public.user_roles 
            WHERE user_id = auth.uid() AND role IN ('admin', 'league_commissioner', 'deputy_commissioner')
        )
    );

-- Grant necessary permissions
GRANT SELECT ON auth.users TO authenticated; 