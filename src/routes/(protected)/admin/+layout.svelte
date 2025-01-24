<script lang="ts">
  import { page } from '$app/stores';
  import { supabase } from '$lib/supabase/client';
  import { theme } from '$lib/stores/theme';
  import { onMount } from 'svelte';
  import Footer from '$lib/components/footer.svelte';
  let isMenuOpen = false;

  const navigationItems = [
    { href: '/admin', label: 'Dashboard' },
    { href: '/admin/matches', label: 'Matches' },
    { href: '/admin/teams', label: 'Teams' },
    { href: '/admin/overlays', label: 'Overlays' }
  ];

  async function handleSignOut() {
    await supabase.auth.signOut();
    // window.location.href = '/login';
  }

  function toggleMenu() {
    isMenuOpen = !isMenuOpen;
  }

  function toggleTheme() {
    $theme = $theme === 'dark' ? 'light' : 'dark';
  }

  onMount(() => {
    // Initialize theme class on mount
    document.documentElement.classList.toggle('dark', $theme === 'dark');
  });
</script>

<div class="bg-whit min-h-screen">
  <nav class="border-b border-gray-200 bg-neutral-100 dark:border-gray-800 dark:bg-neutral-800">
    <div class="mx-auto max-w-7xl">
      <div class="flex h-16 items-center justify-between">
        <div class="flex items-center">
          <div class="flex-shrink-0">
            <span class="text-xl font-bold text-white"></span>
          </div>
          <div class="hidden md:block">
            <div class="flex items-baseline space-x-4">
              {#each navigationItems as item}
                <a
                  href={item.href}
                  class="{$page.url.pathname === item.href
                    ? 'bg-neutral-200 text-gray-900 dark:bg-neutral-900 dark:text-white'
                    : 'text-gray-600 hover:bg-neutral-200 hover:text-gray-900 dark:text-gray-300 dark:hover:bg-neutral-700 dark:hover:text-white'} rounded-md px-3 py-2 text-sm font-medium"
                  aria-current={$page.url.pathname === item.href ? 'page' : undefined}
                >
                  {item.label}
                </a>
              {/each}
            </div>
          </div>
        </div>
        <div class="hidden md:block">
          <div class="ml-4 flex items-center space-x-2 md:ml-6">
            <button
              type="button"
              onclick={toggleTheme}
              class="rounded-md px-2 py-2 text-sm font-semibold hover:bg-neutral-200 dark:text-white dark:hover:bg-neutral-900"
              aria-label={$theme === 'dark' ? 'Switch to light mode' : 'Switch to dark mode'}
            >
              {#if $theme === 'dark'}
                <!-- Sun icon -->
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="16"
                  height="16"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <circle cx="12" cy="12" r="5" />
                  <line x1="12" y1="1" x2="12" y2="3" />
                  <line x1="12" y1="21" x2="12" y2="23" />
                  <line x1="4.22" y1="4.22" x2="5.64" y2="5.64" />
                  <line x1="18.36" y1="18.36" x2="19.78" y2="19.78" />
                  <line x1="1" y1="12" x2="3" y2="12" />
                  <line x1="21" y1="12" x2="23" y2="12" />
                  <line x1="4.22" y1="19.78" x2="5.64" y2="18.36" />
                  <line x1="18.36" y1="5.64" x2="19.78" y2="4.22" />
                </svg>
              {:else}
                <!-- Moon icon -->
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="16"
                  height="16"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                >
                  <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z" />
                </svg>
              {/if}
            </button>

            <!-- svelte-ignore a11y_consider_explicit_label -->
            <button
              type="button"
              onclick={handleSignOut}
              class="rounded-md bg-primary px-2 py-2 text-sm font-semibold text-white hover:bg-red-500"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
                ><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" /><polyline
                  points="16 17 21 12 16 7"
                /><line x1="21" y1="12" x2="9" y2="12" /></svg
              >
            </button>
          </div>
        </div>

        <!-- Mobile menu button -->
        <div class="flex md:hidden">
          <button
            type="button"
            onclick={toggleMenu}
            class="mr-2 inline-flex items-center justify-center rounded-md p-2 text-gray-400 hover:bg-neutral-700 hover:text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800"
          >
            <span class="sr-only">Open main menu</span>
            <!-- Menu icon -->
            <svg
              class={isMenuOpen ? 'hidden' : 'block h-6 w-6'}
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              aria-hidden="true"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M4 6h16M4 12h16M4 18h16"
              />
            </svg>
            <!-- Close icon -->
            <svg
              class={isMenuOpen ? 'block h-6 w-6' : 'hidden'}
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              aria-hidden="true"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M6 18L18 6M6 6l12 12"
              />
            </svg>
          </button>
        </div>
      </div>
    </div>

    <!-- Mobile menu -->
    <div class={isMenuOpen ? 'md:hidden' : 'hidden'}>
      <div class="space-y-1 px-2 pb-3 pt-2 sm:px-3">
        {#each navigationItems as item}
          <a
            href={item.href}
            class="{$page.url.pathname === item.href
              ? 'bg-neutral-900 text-white'
              : 'text-gray-300 hover:bg-neutral-700 hover:text-white'} block rounded-md px-3 py-2 text-base font-medium"
            aria-current={$page.url.pathname === item.href ? 'page' : undefined}
          >
            {item.label}
          </a>
        {/each}
        <button
          type="button"
          onclick={handleSignOut}
          class="mt-4 block w-full rounded-md bg-primary px-3 py-2 text-base font-medium text-white hover:bg-red-500"
        >
          <div class="flex items-center gap-2">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              ><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" /><polyline
                points="16 17 21 12 16 7"
              /><line x1="21" y1="12" x2="9" y2="12" /></svg
            >
            Sign Out
          </div>
        </button>
      </div>
    </div>
  </nav>

  <main>
    <slot />
  </main>
  <Footer />
</div>
