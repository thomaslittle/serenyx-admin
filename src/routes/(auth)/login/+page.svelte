<script lang="ts">
  import { supabase } from '$lib/supabase/client';
  import { auth } from '$lib/stores/auth';
  import type { AuthError } from '@supabase/supabase-js';
  import { Button } from '$lib/components/ui/button/index.js';
  import { Input } from '$lib/components/ui/input/index.js';
  import { Label } from '$lib/components/ui/label/index.js';
  import { Card, CardContent, CardHeader, CardTitle } from '$lib/components/ui/card/index.js';

  let email = '';
  let password = '';
  let loading = false;
  let error: string | null = null;

  async function handleLogin() {
    try {
      console.log('Starting login process...');
      loading = true;
      error = null;

      console.log('Attempting sign in with:', { email });
      const { data, error: signInError } = await supabase.auth.signInWithPassword({
        email,
        password
      });

      if (signInError) {
        console.error('Sign in error:', signInError);
        throw signInError;
      }

      console.log('Sign in successful:', data);

      if (data.session) {
        const { user } = data.session;
        console.log('User from session:', user);

        // Get role from database
        console.log('Fetching role from database for user:', user.id);
        const { data: roleData, error: roleError } = await supabase
          .from('user_roles')
          .select('role')
          .eq('user_id', user.id)
          .maybeSingle();

        console.log('Role query result:', { roleData, roleError });

        if (roleError) {
          console.error('Error fetching role:', roleError);
          console.log('User ID:', user.id);

          // Try to get all roles for debugging
          console.log('Attempting to fetch all roles...');
          const { data: allRoles, error: allRolesError } = await supabase
            .from('user_roles')
            .select('*');

          console.log('All roles query result:', { allRoles, allRolesError });
        }

        // Check both user_roles table and app_metadata
        const dbRole = roleData?.role;
        const metadataRole = user.app_metadata?.role;
        console.log('Roles found:', { dbRole, metadataRole, rawMetadata: user.app_metadata });

        // If user has admin in metadata but not in db, sync it using the RPC function
        if (metadataRole === 'admin' && !dbRole) {
          console.log('Attempting to sync admin role using RPC...');
          const { data: rpcData, error: syncError } = await supabase.rpc('set_role', {
            input_user_id: user.id,
            input_role: 'admin'
          });

          console.log('RPC result:', { rpcData, syncError });

          if (syncError) {
            console.error('Error syncing role:', syncError);
          } else {
            console.log('Successfully synced admin role');

            // Fetch the updated role
            console.log('Fetching updated role...');
            const { data: updatedRole, error: fetchError } = await supabase
              .from('user_roles')
              .select('role')
              .eq('user_id', user.id)
              .maybeSingle();

            console.log('Updated role query result:', { updatedRole, fetchError });
          }
        }

        // Use metadata role if available, otherwise use db role or default to authenticated
        const role = metadataRole || dbRole || 'authenticated';

        // Update auth store
        auth.set({
          user,
          role
        });

        // Force a full page reload to ensure session is properly initialized
        console.log('Redirecting to:', role === 'admin' ? '/admin' : '/');
        window.location.href = role === 'admin' ? '/admin' : '/';
      }
    } catch (e) {
      console.error('Login error:', e);
      error = (e as AuthError).message;
    } finally {
      loading = false;
    }
  }
</script>

<div class="min-h-screen bg-white p-8 dark:bg-neutral-900">
  <div class="mx-auto max-w-md">
    <Card>
      <CardHeader>
        <CardTitle class="text-2xl font-bold">Login</CardTitle>
      </CardHeader>
      <CardContent>
        <form on:submit|preventDefault={handleLogin} class="space-y-4">
          <div class="space-y-2">
            <Label for="email">Email</Label>
            <Input type="email" id="email" bind:value={email} autocomplete="email" required />
          </div>

          <div class="space-y-2">
            <Label for="password">Password</Label>
            <Input
              type="password"
              id="password"
              bind:value={password}
              autocomplete="current-password"
              required
            />
          </div>

          {#if error}
            <div class="rounded-md bg-red-500 p-3 text-sm text-white">
              {error}
            </div>
          {/if}

          <Button type="submit" class="w-full" disabled={loading}>
            {loading ? 'Logging in...' : 'Login'}
          </Button>
        </form>
      </CardContent>
    </Card>
  </div>
</div>
