-- Check current user role
SELECT id, email, role 
FROM auth.users 
WHERE email = 'serenyxproduction@gmail.com';

-- Verify user_role enum exists
SELECT typname, enumlabel 
FROM pg_enum e 
JOIN pg_type t ON e.enumtypid = t.oid 
WHERE typname = 'user_role';

-- Check JWT function
SELECT auth.jwt();

-- Check hooks
SELECT * FROM auth.hooks 
WHERE event = 'JWT_CLAIM';

-- Update role to admin if needed
UPDATE auth.users 
SET role = 'admin'::user_role 
WHERE email = 'serenyxproduction@gmail.com'
RETURNING id, email, role; 