<script lang="ts">
  import { supabase } from '$lib/supabase/client';
  import { goto } from '$app/navigation';
  import { Button } from 'bits-ui';
  export let data;
  const { userData } = data;

  let isMenuOpen = false;

  async function handleLogout() {
    const { error } = await supabase.auth.signOut();
    if (!error) {
      goto('/login');
    }
  }

  function toggleMenu() {
    isMenuOpen = !isMenuOpen;
  }
</script>

<div class="min-h-screen bg-white p-6 dark:bg-neutral-900">
  <!-- Navigation -->
  <nav class="mx-auto max-w-7xl py-4">
    <div class="mx-auto flex max-w-7xl items-center justify-between font-heading">
      <span class="leading-2 text-3xl font-black uppercase text-primary"
        >Serenyx <span class="font-extralight text-white">Broadcast</span></span
      >
    </div>

    <!-- Mobile menu -->
    <div class={isMenuOpen ? 'block md:hidden' : 'hidden'} id="mobile-menu">
      <div class="space-y-1 px-2 pb-3 pt-2">
        <a
          href="/admin/overlays/match"
          class="block rounded-md px-3 py-2 text-base font-medium text-neutral-300 hover:bg-neutral-700 hover:text-white"
          >Match Overlay</a
        >
        <a
          href="/admin/overlays/teams"
          class="block rounded-md px-3 py-2 text-base font-medium text-neutral-300 hover:bg-neutral-700 hover:text-white"
          >Team Standings</a
        >
        <a
          href="/admin/planning/broadcast-script"
          class="block rounded-md px-3 py-2 text-base font-medium text-neutral-300 hover:bg-neutral-700 hover:text-white"
          >Broadcast Script</a
        >
        <button
          on:click={handleLogout}
          class="block w-full rounded-md px-3 py-2 text-left text-base font-medium text-neutral-300 hover:bg-neutral-700 hover:text-white"
          >Logout</button
        >
      </div>
    </div>
  </nav>

  <!-- Main content -->
  <main class="mx-auto max-w-7xl pt-6">
    <div class="flex flex-col gap-4">
      <div class="space-y-0.5">
        <h2 class="text-2xl font-bold tracking-tight">Dashboard</h2>
        <p class="text-muted-foreground">
          Welcome back, {userData.firstName}
        </p>
      </div>
      <div class="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
        <!-- Administration -->
        <!-- <div class="rounded-lg bg-neutral-100 p-6 dark:bg-neutral-800">
          <h3
            class="bg-fill border-l-2 border-primary pl-4 text-xl font-normal uppercase text-gray-900 dark:text-white"
          >
            Administration
          </h3>
          <div class="mt-4 space-y-4">
            <a
              href="/admin/users"
              class="block w-full rounded-md bg-neutral-200 px-4 py-2 text-center text-sm font-medium text-gray-900 hover:bg-neutral-300 dark:bg-neutral-700 dark:text-white dark:hover:bg-neutral-600"
            >
              Manage Users
            </a>
            <a
              href="/admin/profile"
              class="block w-full rounded-md bg-neutral-200 px-4 py-2 text-center text-sm font-medium text-gray-900 hover:bg-neutral-300 dark:bg-neutral-700 dark:text-white dark:hover:bg-neutral-600"
            >
              Manage Profile
            </a>
          </div>
        </div> -->

        <!-- Quick Actions -->
        <div class="rounded-lg bg-neutral-100 p-6 dark:bg-neutral-800">
          <h3
            class="bg-fill border-l-2 border-primary pl-4 text-xl font-normal uppercase text-gray-900 dark:text-white"
          >
            Quick Actions
          </h3>
          <div class="mt-4 space-y-4">
            <a
              href="/admin/overlays/match"
              class="block w-full rounded-md bg-neutral-200 px-4 py-2 text-center text-sm font-medium text-gray-900 hover:bg-neutral-300 dark:bg-neutral-700 dark:text-white dark:hover:bg-neutral-600"
            >
              Start Match Overlay
            </a>
            <a
              href="/admin/overlays/teams"
              class="block w-full rounded-md bg-neutral-200 px-4 py-2 text-center text-sm font-medium text-gray-900 hover:bg-neutral-300 dark:bg-neutral-700 dark:text-white dark:hover:bg-neutral-600"
            >
              Show Team Standings
            </a>
          </div>
        </div>

        <!-- Active Matches -->
        <div class="rounded-lg bg-neutral-100 p-6 dark:bg-neutral-800">
          <h3
            class="border-l-2 border-primary pl-4 text-xl font-normal uppercase text-gray-900 dark:text-white"
          >
            Active Matches
          </h3>
          <div class="mt-4">
            <p class="text-gray-600 dark:text-gray-400">No active matches</p>
          </div>
        </div>

        <!-- Planning -->
        <!-- <div class="rounded-lg bg-neutral-100 p-6 dark:bg-neutral-800">
          <h3
            class="border-l-2 border-primary pl-4 text-xl font-normal uppercase text-gray-900 dark:text-white"
          >
            Planning
          </h3>
          <div class="mt-4 space-y-4">
            <a
              href="/admin/planning/changelog"
              class="block w-full rounded-md bg-neutral-200 px-4 py-2 text-center text-sm font-medium text-gray-900 hover:bg-neutral-300 dark:bg-neutral-700 dark:text-white dark:hover:bg-neutral-600"
            >
              Changelog
            </a>
            <a
              href="/admin/planning/broadcast-script"
              class="block w-full rounded-md bg-neutral-200 px-4 py-2 text-center text-sm font-medium text-gray-900 hover:bg-neutral-300 dark:bg-neutral-700 dark:text-white dark:hover:bg-neutral-600"
            >
              Broadcast Script
            </a>
          </div>
        </div> -->

        <!-- Recent Updates -->
        <div class="rounded-lg bg-neutral-100 p-6 dark:bg-neutral-800">
          <h3
            class="border-l-2 border-primary pl-4 text-xl font-normal uppercase text-gray-900 dark:text-white"
          >
            Recent Updates
          </h3>
          <div class="mt-4">
            <p class="text-gray-600 dark:text-gray-400">No recent updates</p>
          </div>
        </div>
      </div>
    </div>
  </main>
</div>
