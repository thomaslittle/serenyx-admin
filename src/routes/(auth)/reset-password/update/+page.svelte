<script lang="ts">
  import { supabase } from '$lib/supabase/client';
  import { goto } from '$app/navigation';

  let password = '';
  let confirmPassword = '';
  let loading = false;
  let error: string | null = null;

  async function handlePasswordUpdate() {
    try {
      if (password !== confirmPassword) {
        error = "Passwords don't match";
        return;
      }

      loading = true;
      error = null;

      const { error: updateError } = await supabase.auth.updateUser({
        password
      });

      if (updateError) {
        throw updateError;
      }

      // Redirect to login page after successful password reset
      goto('/login');
    } catch (e) {
      error = e.message;
    } finally {
      loading = false;
    }
  }
</script>

<div class="flex min-h-screen items-center justify-center bg-neutral-900">
  <div class="w-full max-w-md space-y-8 rounded-lg bg-neutral-800 p-6 shadow-lg">
    <div>
      <h2 class="text-center text-3xl font-bold tracking-tight text-white">Update your password</h2>
      <p class="mt-2 text-center text-sm text-gray-400">Enter your new password below</p>
    </div>

    <form class="mt-8 space-y-6" on:submit|preventDefault={handlePasswordUpdate}>
      <div class="space-y-4">
        <div>
          <label for="password" class="block text-sm font-medium text-white"> New password </label>
          <div class="mt-1">
            <input
              bind:value={password}
              id="password"
              name="password"
              type="password"
              required
              class="block w-full rounded-md border-0 bg-neutral-700 py-1.5 text-white shadow-sm ring-1 ring-inset ring-gray-600 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-red-600 sm:text-sm sm:leading-6"
              placeholder="••••••••"
            />
          </div>
        </div>

        <div>
          <label for="confirm-password" class="block text-sm font-medium text-white">
            Confirm new password
          </label>
          <div class="mt-1">
            <input
              bind:value={confirmPassword}
              id="confirm-password"
              name="confirm-password"
              type="password"
              required
              class="block w-full rounded-md border-0 bg-neutral-700 py-1.5 text-white shadow-sm ring-1 ring-inset ring-gray-600 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-red-600 sm:text-sm sm:leading-6"
              placeholder="••••••••"
            />
          </div>
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
          class="group relative flex w-full justify-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white hover:bg-red-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-600 disabled:opacity-50"
        >
          {loading ? 'Updating password...' : 'Update password'}
        </button>
      </div>
    </form>
  </div>
</div>
