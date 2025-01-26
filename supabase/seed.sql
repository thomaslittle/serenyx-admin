DO $$
DECLARE
  admin_user_id uuid;
  r record;
BEGIN
  -- Create admin user
  INSERT INTO auth.users (
    instance_id,
    id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    recovery_sent_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    created_at,
    updated_at,
    confirmation_token,
    email_change,
    email_change_token_new,
    recovery_token
  ) VALUES (
    '00000000-0000-0000-0000-000000000000',
    gen_random_uuid(),
    'authenticated',
    'authenticated',
    'admin@serenyx.com',
    crypt('admin123', gen_salt('bf')),
    now(),
    now(),
    now(),
    '{"provider": "email", "providers": ["email"]}',
    '{"email_verified": true}',
    now(),
    now(),
    '',
    '',
    '',
    ''
  ) RETURNING id INTO admin_user_id;

  -- Assign admin role
  INSERT INTO public.user_roles (user_id, role)
  VALUES (admin_user_id, 'admin');

  -- Set role in app_metadata
  PERFORM set_role(admin_user_id, 'admin');

  -- Log the created user and role
  RAISE NOTICE 'Created admin user with ID: %', admin_user_id;
  
  -- Verify role assignment
  RAISE NOTICE 'Verifying role assignment...';
  RAISE NOTICE 'User roles:';
  FOR r IN (
    SELECT u.email, ur.role, u.raw_app_meta_data
    FROM auth.users u 
    JOIN public.user_roles ur ON u.id = ur.user_id
  ) LOOP
    RAISE NOTICE 'Email: %, Role: %, Metadata: %', r.email, r.role, r.raw_app_meta_data;
  END LOOP;
END $$; 
