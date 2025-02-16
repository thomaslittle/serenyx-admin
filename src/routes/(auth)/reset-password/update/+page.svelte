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
      <h2 class="font-heading text-center text-3xl font-bold tracking-tight text-white">
        Update your password
      </h2>
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
        <div class="mt-4 flex items-center gap-2 rounded-md border border-primary/40 p-2">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="24"
            height="24"
            viewBox="0 0 24 24"
            class="stroke-primary"
            ><g fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
              ><path d="M20 16v2m0 4.01l.01-.011M4 6v6s0 3 7 3s7-3 7-3V6" /><path
                d="M11 3c7 0 7 3 7 3s0 3-7 3s-7-3-7-3s0-3 7-3m0 18c-7 0-7-3-7-3v-6"
              /></g
            ></svg
          >
          <p class="text-sm capitalize leading-none text-neutral-900 dark:text-white">{error}</p>
        </div>
      {/if}

      <div>
        <button
          type="submit"
          disabled={loading}
          class="group relative flex w-full justify-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-600 disabled:opacity-50"
        >
          {loading ? 'Updating password...' : 'Update password'}
        </button>
      </div>
    </form>
  </div>
</div>
