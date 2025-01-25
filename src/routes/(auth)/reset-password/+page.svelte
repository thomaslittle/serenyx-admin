<script lang="ts">
  import { supabase } from '$lib/supabase/client';

  let email = '';
  let loading = false;
  let error: string | null = null;
  let success = false;

  async function handleResetRequest() {
    try {
      loading = true;
      error = null;
      success = false;

      const { error: resetError } = await supabase.auth.resetPasswordForEmail(email, {
        redirectTo: `${window.location.origin}/reset-password/update`
      });

      if (resetError) {
        throw resetError;
      }

      success = true;
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
        Reset your password
      </h2>
      <p class="mt-2 text-center text-sm text-gray-400">
        Enter your email address and we'll send you a password reset link
      </p>
    </div>

    {#if success}
      <div class="rounded-md bg-green-500 bg-opacity-10 p-4">
        <div class="flex">
          <div class="ml-3">
            <h3 class="text-sm font-medium text-green-400">Reset link sent</h3>
            <div class="mt-2 text-sm text-green-300">
              <p>Check your email for the password reset link.</p>
            </div>
            <div class="mt-4">
              <a href="/login" class="text-sm font-medium text-green-400 hover:text-green-300">
                Return to login
              </a>
            </div>
          </div>
        </div>
      </div>
    {:else}
      <form class="mt-8 space-y-6" on:submit|preventDefault={handleResetRequest}>
        <div>
          <label for="email" class="block text-sm font-medium text-white"> Email address </label>
          <div class="mt-1">
            <input
              bind:value={email}
              id="email"
              name="email"
              type="email"
              required
              class="block w-full rounded-md border-0 bg-neutral-700 py-1.5 text-white shadow-sm ring-1 ring-inset ring-gray-600 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-red-600 sm:text-sm sm:leading-6"
              placeholder="you@example.com"
            />
          </div>
        </div>

        {#if error}
          <div class="rounded-md bg-red-500 p-4">
            <p class="text-sm capitalize leading-none text-neutral-900 dark:text-white">{error}</p>
          </div>
        {/if}

        <div>
          <button
            type="submit"
            disabled={loading}
            class="group relative flex w-full justify-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-600 disabled:opacity-50"
          >
            {loading ? 'Sending reset link...' : 'Send reset link'}
          </button>
        </div>

        <div class="text-center">
          <a href="/login" class="text-sm font-medium text-primary hover:text-red-500">
            Back to login
          </a>
        </div>
      </form>
    {/if}
  </div>
</div>
