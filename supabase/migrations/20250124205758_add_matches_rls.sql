-- Enable RLS on matches table
ALTER TABLE public.matches ENABLE ROW LEVEL SECURITY;

-- Create policies for matches table
CREATE POLICY "Enable read access for all users"
ON public.matches FOR SELECT
TO authenticated
USING (true);

CREATE POLICY "Enable insert for admin users"
ON public.matches FOR INSERT
TO authenticated
WITH CHECK (
  EXISTS (
    SELECT 1
    FROM auth.users
    WHERE auth.users.id = auth.uid()
    AND (
      (auth.users.raw_app_meta_data->>'role' = 'admin') OR
      EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_roles.user_id = auth.uid()
        AND user_roles.role = 'admin'
      )
    )
  )
);

CREATE POLICY "Enable update for admin users"
ON public.matches FOR UPDATE
TO authenticated
USING (
  EXISTS (
    SELECT 1
    FROM auth.users
    WHERE auth.users.id = auth.uid()
    AND (
      (auth.users.raw_app_meta_data->>'role' = 'admin') OR
      EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_roles.user_id = auth.uid()
        AND user_roles.role = 'admin'
      )
    )
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1
    FROM auth.users
    WHERE auth.users.id = auth.uid()
    AND (
      (auth.users.raw_app_meta_data->>'role' = 'admin') OR
      EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_roles.user_id = auth.uid()
        AND user_roles.role = 'admin'
      )
    )
  )
);

CREATE POLICY "Enable delete for admin users"
ON public.matches FOR DELETE
TO authenticated
USING (
  EXISTS (
    SELECT 1
    FROM auth.users
    WHERE auth.users.id = auth.uid()
    AND (
      (auth.users.raw_app_meta_data->>'role' = 'admin') OR
      EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_roles.user_id = auth.uid()
        AND user_roles.role = 'admin'
      )
    )
  )
); 