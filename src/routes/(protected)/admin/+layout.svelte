<script lang="ts">
  import { page } from '$app/stores';
  import { supabase } from '$lib/supabase/client';
  import { theme } from '$lib/stores/theme';
  import { onMount } from 'svelte';
  import Footer from '$lib/components/Footer.svelte';
  import BackgroundImage from '$lib/components/BackgroundImage.svelte';
  import Home from 'lucide-svelte/icons/home';
  import Users from 'lucide-svelte/icons/users';
  import Box from 'lucide-svelte/icons/box';
  import Settings from 'lucide-svelte/icons/settings';

  let isMenuOpen = false;

  const navigationItems = [
    { href: '/admin', label: 'Dashboard', icon: Home },
    // { href: '/admin/users', label: 'Users', icon: Users },
    { href: '/admin/matches', label: 'Matches', icon: Home },
    { href: '/admin/teams', label: 'Teams', icon: Users },
    { href: '/admin/overlays', label: 'Overlays', icon: Box }
    // { href: '/admin/sandbox', label: 'Sandbox', icon: Box }
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
    // Always initialize with dark theme
    document.documentElement.classList.add('dark');
    $theme = 'dark';
  });
</script>

<BackgroundImage src="/images/bg.webp" alt="Abstract background" opacity={0.5} zIndex={0} />

<div class="relative min-h-screen">
  <nav
    class="border-b border-neutral-200 bg-neutral-100 px-6 dark:border-neutral-800 dark:bg-neutral-800"
  >
    <div class="mx-auto max-w-7xl">
      <div class="flex h-16 items-center justify-between">
        <a href="/">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            version="1.2"
            viewBox="807 1349 876 812"
            class="size-7 fill-primary text-white"
          >
            <path
              d="M1604.6 1386.3h-365.8l-36.5 207h459l20.3-115.2c8.5-47.9-28.4-91.8-77-91.8zm-6.8 567h-774l-15.1 85.7c-11.1 63.3 37.6 121.3 101.9 121.3h564.5c49.9 0 92.6-35.8 101.2-84.9z"
              class="s0"
            />
            <path
              d="m1647.5 1674.3-37 207h-774l30.8-174.7 5.7-32.5 30.7-173.8h-.1l11.6-66c8.7-49.1 51.4-85 101.3-85h147.8l-6.5 37-50.8 288z"
              class="s0"
            />
          </svg>
        </a>
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
                    ? 'bg-neutral-200 text-gray-900 dark:bg-neutral-900/80 dark:text-white'
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
              class="rounded-md px-2 py-2 text-sm font-semibold hover:bg-neutral-200 dark:text-white dark:hover:bg-neutral-900/80"
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
              class="rounded-md bg-primary px-2 py-2 text-sm font-semibold text-white"
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
            class="inline-flex items-center justify-center rounded-md p-2 text-gray-400 hover:bg-neutral-700 hover:text-white focus:outline-none"
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
      <div class="space-y-1 pb-3 pt-2">
        {#each navigationItems as item}
          <a
            href={item.href}
            class="{$page.url.pathname === item.href
              ? 'bg-neutral-900 text-white'
              : 'text-neutral-300 hover:bg-neutral-700 hover:text-white'} block rounded-md px-3 py-2 text-base font-medium"
            aria-current={$page.url.pathname === item.href ? 'page' : undefined}
          >
            {item.label}
          </a>
        {/each}
        <button
          type="button"
          onclick={handleSignOut}
          class="mt-4 block w-full rounded-md bg-primary px-3 py-2 text-base font-medium text-white"
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
