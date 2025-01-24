<script lang="ts">
  import { supabase } from '$lib/supabase/client';
  import { auth } from '$lib/stores/auth';
  import type { AuthError } from '@supabase/supabase-js';

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
        const role = data.session.user.role || 'user';
        console.log('Login successful:', { user: data.session.user.email, role });

        // Update auth store
        auth.set({
          user: data.session.user,
          role
        });

        // Force a full page reload to ensure session is properly initialized
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

<div class="min-h-screen bg-neutral-900 p-8">
  <div class="mx-auto max-w-md">
    <div class="rounded-lg bg-neutral-800 p-8">
      <h1 class="mb-6 text-3xl font-bold text-white">Login</h1>

      <form on:submit|preventDefault={handleLogin} class="space-y-4">
        <div>
          <label for="email" class="block text-sm font-medium text-white">Email</label>
          <input
            type="email"
            id="email"
            bind:value={email}
            autocomplete="email"
            class="mt-1 block w-full rounded-md border-gray-600 bg-neutral-700 text-white"
            required
          />
        </div>

        <div>
          <label for="password" class="block text-sm font-medium text-white">Password</label>
          <input
            type="password"
            id="password"
            bind:value={password}
            autocomplete="current-password"
            class="mt-1 block w-full rounded-md border-gray-600 bg-neutral-700 text-white"
            required
          />
        </div>

        {#if error}
          <div class="rounded-md bg-red-500 p-3 text-white">{error}</div>
        {/if}

        <button
          type="submit"
          class="hover:bg-primary-dark w-full rounded-md bg-primary px-4 py-2 text-white disabled:opacity-50"
          disabled={loading}
        >
          {loading ? 'Logging in...' : 'Login'}
        </button>
      </form>
    </div>
  </div>
</div>
