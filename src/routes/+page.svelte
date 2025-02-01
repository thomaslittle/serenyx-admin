<script lang="ts">
  import { auth, hasPermission } from '$lib/stores/auth';
  import { supabase } from '$lib/supabase/client';
  import Loader from '$lib/components/ui/loader.svelte';
  import { onMount } from 'svelte';

  $: ({ user, role } = $auth);

  let timeLeft = '00:00:00';
  let countdownOver = false;

  function updateCountdown() {
    const now = new Date();
    const target = new Date();
    target.setHours(18, 15, 0, 0); // 6:15 PM

    if (now > target) {
      target.setDate(target.getDate() + 1);
    }

    const diff = target - now;
    if (diff <= 0) {
      countdownOver = true;
      return;
    }

    const hours = Math.floor(diff / (1000 * 60 * 60));
    const minutes = Math.floor((diff / (1000 * 60)) % 60);
    const seconds = Math.floor((diff / 1000) % 60);

    const formattedHours = hours > 0 ? hours : '';
    timeLeft = `${formattedHours}:${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`;
  }

  onMount(() => {
    updateCountdown();
    const interval = setInterval(updateCountdown, 1000);
    return () => clearInterval(interval);
  });

  async function handleLogout() {
    await supabase.auth.signOut();
    window.location.href = '/login';
  }
</script>

<main>
  <div class="relative flex min-h-screen items-center justify-center bg-neutral-900">
    <!-- Countdown Timer or Twitch Logo -->
    <div class="pointer-events-none absolute inset-0 flex items-center justify-center">
      {#if !countdownOver}
        <div
          class="xs:text-[8rem] z-0 select-none font-mono text-[6rem] font-bold tracking-tighter
                 text-[#ea0e4b] opacity-10 blur-sm sm:text-[12rem] md:text-[15rem] lg:text-[20rem]"
        >
          {timeLeft}
        </div>
      {:else}
        <a
          href="https://www.twitch.tv/serenyxleague"
          target="_blank"
          rel="noopener noreferrer"
          class="pointer-events-auto z-0 opacity-10 transition-opacity hover:opacity-20"
        >
          <svg
            class="h-64 w-64 sm:h-96 sm:w-96"
            viewBox="0 0 24 24"
            fill="currentColor"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M4.262 1L2 4.5V19.5H6.5V23H10.5L14 19.5H18L22 15.5V1H4.262ZM20 14.5L18 16.5H14L10.5 20V16.5H6V3H20V14.5ZM16 7.5H14.5V12H16V7.5ZM11.5 7.5H10V12H11.5V7.5Z"
            />
          </svg>
        </a>
      {/if}
    </div>

    {#if user}
      <div class="relative z-10 mx-auto max-w-7xl">
        <div class="rounded-lg bg-neutral-800 p-8">
          <div class="flex items-center justify-between">
            <h1 class="text-3xl font-bold text-white">
              Hello {user.email}
            </h1>
            <button
              on:click={handleLogout}
              class="rounded-md bg-red-600 px-4 py-2 text-white transition hover:bg-red-700"
            >
              Logout
            </button>
          </div>

          <div class="mt-6 space-y-4 text-white">
            <h2 class="font-heading text-xl font-semibold">Debug Information:</h2>
            <div class="space-y-2 rounded-lg bg-neutral-700 p-4">
              <p>
                Access Level: <span class="font-semibold text-primary"
                  >{role === 'admin' ? 'Admin' : role || 'User'}</span
                >
              </p>
              <p>User ID: <span class="font-mono">{user.id}</span></p>
              <p>Email: {user.email}</p>
              <p>Email Verified: {user.email_confirmed_at ? 'Yes' : 'No'}</p>
              <p>Last Sign In: {new Date(user.last_sign_in_at || '').toLocaleString()}</p>
              <p>Created At: {new Date(user.created_at).toLocaleString()}</p>
              <p>Auth Provider: {user.app_metadata.provider}</p>
              <p>JWT Role: {user.user_metadata?.user_role || 'Not Set'}</p>
              <p>App Role: {role || 'Not Set'}</p>
              <p>Permissions:</p>
              <ul class="ml-4 list-disc">
                <li>
                  Can Delete Channels: {hasPermission(role, 'channels.delete') ? 'Yes' : 'No'}
                </li>
                <li>
                  Can Delete Messages: {hasPermission(role, 'messages.delete') ? 'Yes' : 'No'}
                </li>
              </ul>
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

          <div class="mt-8">
            <h2 class="font-heading text-xl font-semibold text-white">Available Pages:</h2>
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
            <a
              href="/login"
              class="inline-block rounded-md bg-primary px-4 py-2 text-white transition hover:bg-red-600"
            >
              Login
            </a>
          </div>
        </div>
      </div>
    {:else}
      <Loader width="100" height="100" className="text-white relative z-10" />
    {/if}
  </div>
</main>
