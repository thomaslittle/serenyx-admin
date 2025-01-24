<script lang="ts">
  import { auth } from '$lib/stores/auth';
  import { supabase } from '$lib/supabase/client';

  $: ({ user, role } = $auth);

  async function handleLogout() {
    await supabase.auth.signOut();
    window.location.href = '/login';
  }
</script>

<main>
  <div class="min-h-screen bg-neutral-900">
    <div class="mx-auto max-w-7xl">
      <div class="rounded-lg bg-neutral-800 p-8">
        <div class="flex items-center justify-between">
          <h1 class="text-3xl font-bold text-white">
            {#if user}
              Hello {user.email}
            {:else}
              Welcome Guest
            {/if}
          </h1>
          {#if user}
            <button
              on:click={handleLogout}
              class="rounded-md bg-red-600 px-4 py-2 text-white transition hover:bg-red-700"
            >
              Logout
            </button>
          {/if}
        </div>

        {#if user}
          <div class="mt-6 space-y-4 text-white">
            <h2 class="text-xl font-semibold">Debug Information:</h2>
            <div class="space-y-2 rounded-lg bg-neutral-700 p-4">
              <p>
                Access Level: <span class="font-semibold text-primary"
                  >{role === 'admin' ? 'Admin' : 'User'}</span
                >
              </p>
              <p>User ID: <span class="font-mono">{user.id}</span></p>
              <p>Email: {user.email}</p>
              <p>Email Verified: {user.email_confirmed_at ? 'Yes' : 'No'}</p>
              <p>Last Sign In: {new Date(user.last_sign_in_at || '').toLocaleString()}</p>
              <p>Created At: {new Date(user.created_at).toLocaleString()}</p>
              <p>Auth Provider: {user.app_metadata.provider}</p>
              <p>Database is_admin: {role === 'admin' ? 'Yes' : 'No'}</p>
              <details class="mt-4">
                <summary class="cursor-pointer hover:text-primary">Raw User Object</summary>
                <pre class="mt-2 overflow-auto rounded bg-neutral-800 p-2 text-xs">
								{JSON.stringify(user, null, 2)}
							</pre>
              </details>
              <details class="mt-4">
                <summary class="cursor-pointer hover:text-primary">Auth Store State</summary>
                <pre class="mt-2 overflow-auto rounded bg-neutral-800 p-2 text-xs">
								{JSON.stringify($auth, null, 2)}
							</pre>
              </details>
            </div>
          </div>
        {/if}

        <div class="mt-8">
          <h2 class="text-xl font-semibold text-white">Available Pages:</h2>
          <div class="mt-4 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {#if role === 'admin'}
              <a
                href="/admin"
                class="rounded-lg bg-neutral-700 p-4 text-white transition hover:bg-neutral-600"
              >
                <h3 class="font-semibold">Admin Dashboard</h3>
                <p class="mt-1 text-sm text-gray-300">Manage teams, matches, and overlays</p>
              </a>
            {/if}
            <a
              href="/schedule"
              class="rounded-lg bg-neutral-700 p-4 text-white transition hover:bg-neutral-600"
            >
              <h3 class="font-semibold">Match Schedule</h3>
              <p class="mt-1 text-sm text-gray-300">View upcoming matches</p>
            </a>
            <a
              href="/standings"
              class="rounded-lg bg-neutral-700 p-4 text-white transition hover:bg-neutral-600"
            >
              <h3 class="font-semibold">Standings</h3>
              <p class="mt-1 text-sm text-gray-300">View team rankings and stats</p>
            </a>
          </div>
        </div>

        <div class="mt-8">
          {#if !user}
            <a
              href="/login"
              class="inline-block rounded-md bg-primary px-4 py-2 text-white transition hover:bg-red-600"
            >
              Login
            </a>
          {/if}
        </div>
      </div>
    </div>
  </div>
</main>
