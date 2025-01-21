<script lang="ts">
  import { supabase } from '$lib/supabase/client';
  import { goto } from '$app/navigation';
  
  let email = '';
  let password = '';
  let confirmPassword = '';
  let loading = false;
  let error: string | null = null;
  
  async function handleSignup() {
    try {
      if (password !== confirmPassword) {
        error = "Passwords don't match";
        return;
      }
      
      loading = true;
      error = null;
      
      const { data, error: signUpError } = await supabase.auth.signUp({
        email,
        password,
        options: {
          emailRedirectTo: `${window.location.origin}/auth/callback`
        }
      });
      
      if (signUpError) {
        throw signUpError;
      }

      // If email confirmation is required
      if (data?.user && !data.user.confirmed_at) {
        goto('/signup/confirm');
      } else {
        goto('/admin');
      }
      
    } catch (e) {
      error = e.message;
    } finally {
      loading = false;
    }
  }
</script>

<div class="flex min-h-screen items-center justify-center bg-gray-900">
  <div class="w-full max-w-md space-y-8 rounded-lg bg-gray-800 p-6 shadow-lg">
    <div>
      <h2 class="text-center text-3xl font-bold tracking-tight text-white">
        Create a Broadcast Account
      </h2>
      <p class="mt-2 text-center text-sm text-gray-400">
        Sign up to manage Serenyx League broadcasts
      </p>
    </div>
    
    <form class="mt-8 space-y-6" on:submit|preventDefault={handleSignup}>
      <div class="space-y-4 rounded-md">
        <div>
          <label for="email" class="text-sm font-medium text-white">Email address</label>
          <input
            bind:value={email}
            id="email"
            name="email"
            type="email"
            required
            class="mt-1 block w-full rounded-md border-0 bg-gray-700 py-1.5 text-white shadow-sm ring-1 ring-inset ring-gray-600 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-red-600 sm:text-sm sm:leading-6"
            placeholder="you@example.com"
          />
        </div>

        <div>
          <label for="password" class="text-sm font-medium text-white">Password</label>
          <input
            bind:value={password}
            id="password"
            name="password"
            type="password"
            required
            class="mt-1 block w-full rounded-md border-0 bg-gray-700 py-1.5 text-white shadow-sm ring-1 ring-inset ring-gray-600 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-red-600 sm:text-sm sm:leading-6"
            placeholder="••••••••"
          />
        </div>

        <div>
          <label for="confirm-password" class="text-sm font-medium text-white">Confirm password</label>
          <input
            bind:value={confirmPassword}
            id="confirm-password"
            name="confirm-password"
            type="password"
            required
            class="mt-1 block w-full rounded-md border-0 bg-gray-700 py-1.5 text-white shadow-sm ring-1 ring-inset ring-gray-600 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-red-600 sm:text-sm sm:leading-6"
            placeholder="••••••••"
          />
        </div>
      </div>

      {#if error}
        <div class="rounded-md bg-red-500 p-4">
          <p class="text-sm text-white">{error}</p>
        </div>
      {/if}

      <div>
        <button
          type="submit"
          disabled={loading}
          class="group relative flex w-full justify-center rounded-md bg-red-600 px-3 py-2 text-sm font-semibold text-white hover:bg-red-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-600 disabled:opacity-50"
        >
          {loading ? 'Creating account...' : 'Sign up'}
        </button>
      </div>

      <div class="text-center">
        <a href="/login" class="text-sm text-red-600 hover:text-red-500">
          Already have an account? Sign in
        </a>
      </div>
    </form>
  </div>
</div>
