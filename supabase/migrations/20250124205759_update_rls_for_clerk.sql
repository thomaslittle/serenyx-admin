-- Drop existing policies
DROP POLICY IF EXISTS "Admin full access" ON public.matches;
DROP POLICY IF EXISTS "Admin full access" ON public.teams;
DROP POLICY IF EXISTS "Enable full access for admin users" ON public.matches;
DROP POLICY IF EXISTS "Enable full access for admin users" ON public.teams;

-- Create new policies for matches
CREATE POLICY "Enable full access for admin users" ON public.matches
FOR ALL TO authenticated 
USING (
    current_setting('request.jwt.claims', true)::jsonb -> 'app_metadata' ->> 'role' = 'admin'
)
WITH CHECK (
    current_setting('request.jwt.claims', true)::jsonb -> 'app_metadata' ->> 'role' = 'admin'
);

-- Create new policies for teams
CREATE POLICY "Enable full access for admin users" ON public.teams
FOR ALL TO authenticated 
USING (
    current_setting('request.jwt.claims', true)::jsonb -> 'app_metadata' ->> 'role' = 'admin'
)
WITH CHECK (
    current_setting('request.jwt.claims', true)::jsonb -> 'app_metadata' ->> 'role' = 'admin'
);

-- Create function to set claims from Clerk JWT
CREATE OR REPLACE FUNCTION auth.set_clerk_claims()
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  IF current_setting('request.jwt.claims', true)::jsonb ? 'app_metadata' THEN
    RETURN;
  END IF;

  PERFORM set_config(
    'request.jwt.claims',
    jsonb_set(
      current_setting('request.jwt.claims', true)::jsonb,
      '{app_metadata}',
      jsonb_build_object(
        'role',
        current_setting('request.jwt.claims', true)::jsonb -> 'publicMetadata' ->> 'role'
      )
    )::text,
    true
  );
END;
$$; 