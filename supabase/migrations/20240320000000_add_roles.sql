-- Create roles enum if it doesn't exist
DO $$ BEGIN
    CREATE TYPE user_role AS ENUM ('admin', 'moderator', 'user');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- Add role column if it doesn't exist
DO $$ BEGIN
    ALTER TABLE auth.users ADD COLUMN role user_role DEFAULT 'user';
EXCEPTION
    WHEN duplicate_column THEN null;
END $$;

-- Create or replace the users view
CREATE OR REPLACE VIEW public.users AS
SELECT 
    id,
    email,
    role
FROM auth.users;

-- Update RLS policies
ALTER TABLE public.teams ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.matches ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.versions ENABLE ROW LEVEL SECURITY;

-- Admin can do everything
CREATE POLICY "Admins have full access"
ON public.teams
FOR ALL
TO authenticated
USING (auth.jwt() ->> 'role' = 'admin')
WITH CHECK (auth.jwt() ->> 'role' = 'admin');

-- Moderators can view and update but not delete
CREATE POLICY "Moderators can view and update teams"
ON public.teams
FOR SELECT
TO authenticated
USING (auth.jwt() ->> 'role' IN ('admin', 'moderator'));

CREATE POLICY "Moderators can update teams"
ON public.teams
FOR UPDATE
TO authenticated
USING (auth.jwt() ->> 'role' IN ('admin', 'moderator'))
WITH CHECK (auth.jwt() ->> 'role' IN ('admin', 'moderator'));

-- Add policies for matches
CREATE POLICY "Admins have full access to matches"
ON public.matches
FOR ALL
TO authenticated
USING (auth.jwt() ->> 'role' = 'admin')
WITH CHECK (auth.jwt() ->> 'role' = 'admin');

CREATE POLICY "Moderators can view and update matches"
ON public.matches
FOR SELECT
TO authenticated
USING (auth.jwt() ->> 'role' IN ('admin', 'moderator'));

CREATE POLICY "Moderators can update matches"
ON public.matches
FOR UPDATE
TO authenticated
USING (auth.jwt() ->> 'role' IN ('admin', 'moderator'))
WITH CHECK (auth.jwt() ->> 'role' IN ('admin', 'moderator'));

-- Add policies for versions
CREATE POLICY "Admins have full access to versions"
ON public.versions
FOR ALL
TO authenticated
USING (auth.jwt() ->> 'role' = 'admin')
WITH CHECK (auth.jwt() ->> 'role' = 'admin');

CREATE POLICY "Moderators can view and create versions"
ON public.versions
FOR SELECT
TO authenticated
USING (auth.jwt() ->> 'role' IN ('admin', 'moderator'));

CREATE POLICY "Moderators can create versions"
ON public.versions
FOR INSERT
TO authenticated
WITH CHECK (auth.jwt() ->> 'role' IN ('admin', 'moderator'));

-- Create a function to include role in JWT
CREATE OR REPLACE FUNCTION auth.user_role()
RETURNS jsonb
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT 
    jsonb_build_object(
      'role',
      role::text
    )
  FROM auth.users
  WHERE id = auth.uid();
$$;

-- Enable the JWT claim
CREATE OR REPLACE FUNCTION auth.jwt()
RETURNS jsonb
LANGUAGE sql
STABLE
AS $$
  SELECT 
    coalesce(
      nullif(current_setting('request.jwt.claim', true), ''),
      '{}'
    )::jsonb || 
    jsonb_build_object('role', (auth.user_role()->>'role'))
$$;

-- Configure JWT claim
DELETE FROM auth.hooks WHERE hook = 'auth.user_role()';
INSERT INTO auth.hooks (event, hook)
VALUES ('JWT_CLAIM', 'auth.user_role()'); 