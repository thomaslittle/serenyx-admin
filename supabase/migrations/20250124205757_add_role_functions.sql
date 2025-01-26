-- Create function to get available roles
CREATE OR REPLACE FUNCTION get_available_roles()
RETURNS TABLE (role text)
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY SELECT unnest(enum_range(NULL::app_role)::text[]);
END;
$$;

-- Grant execute permission on get_available_roles function
GRANT EXECUTE ON FUNCTION get_available_roles() TO authenticated;

-- Update set_role function to handle new roles
CREATE OR REPLACE FUNCTION set_role(input_user_id uuid, input_role text)
RETURNS void
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql
AS $$
DECLARE
  caller_role text;
  target_user_role text;
BEGIN
  -- Get the role of the caller
  SELECT role INTO caller_role FROM auth.users WHERE id = auth.uid();
  
  -- Get the current role of the target user
  SELECT role INTO target_user_role FROM auth.users WHERE id = input_user_id;

  -- Only admin, league_commissioner, and deputy_commissioner can set roles
  IF NOT (caller_role IN ('admin', 'league_commissioner', 'deputy_commissioner')) THEN
    RAISE EXCEPTION 'Insufficient permissions to set roles';
  END IF;

  -- League commissioner and deputy commissioner cannot modify admin roles
  IF (caller_role IN ('league_commissioner', 'deputy_commissioner') AND 
      (target_user_role = 'admin' OR input_role = 'admin')) THEN
    RAISE EXCEPTION 'Cannot modify admin roles';
  END IF;

  -- Update the user's role in app_metadata
  UPDATE auth.users 
  SET raw_app_meta_data = 
    CASE 
      WHEN raw_app_meta_data IS NULL THEN 
        jsonb_build_object('role', input_role)
      ELSE
        raw_app_meta_data || jsonb_build_object('role', input_role)
    END
  WHERE id = input_user_id;

  -- Update or insert the role in user_roles table
  INSERT INTO user_roles (user_id, role)
  VALUES (input_user_id, input_role::app_role)
  ON CONFLICT (user_id) 
  DO UPDATE SET role = EXCLUDED.role;
END;
$$; 