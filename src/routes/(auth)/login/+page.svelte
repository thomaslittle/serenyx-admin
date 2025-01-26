<script lang="ts">
  import { supabase } from '$lib/supabase/client';
  import { auth } from '$lib/stores/auth';
  import type { AuthError } from '@supabase/supabase-js';
  import { Button } from '$lib/components/ui/button/index.js';
  import { Input } from '$lib/components/ui/input/index.js';
  import { Label } from '$lib/components/ui/label/index.js';
  import {
    Card,
    CardContent,
    CardHeader,
    CardTitle,
    CardDescription
  } from '$lib/components/ui/card/index.js';
  import { Separator } from '$lib/components/ui/separator/index.js';
  import DiscordLogo from 'virtual:icons/logos/discord-icon';

  let email = '';
  let password = '';
  let loading = false;
  let error: string | null = null;

  async function handleLogin() {
    try {
      loading = true;
      error = null;

      const { data, error: signInError } = await supabase.auth.signInWithPassword({
        email,
        password
      });

      if (signInError) throw signInError;

      if (data.session) {
        const { user } = data.session;

        // Get role from database
        const { data: roleData, error: roleError } = await supabase
          .from('user_roles')
          .select('role')
          .eq('user_id', user.id)
          .maybeSingle();

        if (roleError) throw roleError;

        // Check both user_roles table and app_metadata
        const dbRole = roleData?.role;
        const metadataRole = user.app_metadata?.role;

        // If user has admin in metadata but not in db, sync it
        if (metadataRole === 'admin' && !dbRole) {
          const { error: syncError } = await supabase.rpc('set_role', {
            input_user_id: user.id,
            input_role: 'admin'
          });

          if (syncError) throw syncError;
        }

        // Use metadata role if available, otherwise use db role or default to authenticated
        const role = metadataRole || dbRole || 'authenticated';

        // Update auth store
        auth.set({ user, role });

        // Redirect based on role
        window.location.href = role === 'admin' ? '/admin' : '/';
      }
    } catch (e) {
      error = (e as AuthError).message;
    } finally {
      loading = false;
    }
  }

  async function handleDiscordLogin() {
    try {
      loading = true;
      error = null;

      const { data, error: signInError } = await supabase.auth.signInWithOAuth({
        provider: 'discord',
        options: {
          redirectTo: `${window.location.origin}/auth/callback`,
          scopes: 'identify email'
        }
      });

      if (signInError) throw signInError;
    } catch (e) {
      error = (e as AuthError).message;
      loading = false;
    }
  }
</script>

<div class="flex min-h-[calc(100vh-8rem)] items-center justify-center">
  <div class="w-full max-w-sm px-4">
    <Card>
      <CardHeader class="space-y-1">
        <CardTitle class="text-center text-2xl">Welcome back</CardTitle>
        <CardDescription class="text-center">Sign in to your account</CardDescription>
      </CardHeader>
      <CardContent>
        <div class="grid gap-6">
          <form on:submit|preventDefault={handleLogin} class="grid gap-4">
            <div class="grid gap-2">
              <Label for="email">Email</Label>
              <Input
                id="email"
                type="email"
                bind:value={email}
                autocomplete="email"
                placeholder="m@example.com"
                required
              />
            </div>

            <div class="grid gap-2">
              <Label for="password">Password</Label>
              <Input
                id="password"
                type="password"
                bind:value={password}
                autocomplete="current-password"
                required
              />
            </div>

            {#if error}
              <div class="rounded-md bg-destructive/10 p-3 text-sm text-destructive">
                {error}
              </div>
            {/if}

            <Button type="submit" disabled={loading}>
              {loading ? 'Signing in...' : 'Sign in'}
            </Button>
          </form>

          <div class="relative">
            <div class="absolute inset-0 flex items-center">
              <span class="w-full border-t" />
            </div>
            <div class="relative flex justify-center text-xs uppercase">
              <span class="bg-card px-2 text-muted-foreground">Or continue with</span>
            </div>
          </div>

          <Button variant="outline" class="gap-2" onclick={handleDiscordLogin} disabled={loading}>
            <DiscordLogo class="size-4" />
            Discord
          </Button>
        </div>
      </CardContent>
    </Card>
  </div>
</div>
