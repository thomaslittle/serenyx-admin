<script lang="ts">
  import { page } from '$app/stores';
  import { spring } from 'svelte/motion';
  import { fade, slide } from 'svelte/transition';
  
  const links = [
    { href: '/admin/matches', label: 'Matches', icon: 'game-controller' },
    { href: '/admin/teams', label: 'Teams', icon: 'users' },
    { href: '/admin/overlays', label: 'Overlays', icon: 'layout' },
    { href: '/admin/planning', label: 'Planning', icon: 'calendar' }
  ];

  const indicatorSpring = spring({ x: 0, width: 0 }, {
    stiffness: 0.15,
    damping: 0.7
  });

  let navElement: HTMLElement;

  $: {
    const activeLink = navElement?.querySelector(`[href="${$page.url.pathname}"]`);
    if (activeLink) {
      const { offsetLeft, offsetWidth } = activeLink as HTMLElement;
      indicatorSpring.set({ x: offsetLeft, width: offsetWidth });
    }
  }
</script>

<nav bind:this={navElement} 
  class="fixed top-0 left-0 right-0 z-50 border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
  <div class="container flex h-16 items-center">
    <a href="/admin" class="flex items-center gap-2 mr-8">
      <img src="/logo.svg" alt="Serenyx" class="w-8 h-8" />
      <span class="font-bold text-lg">Serenyx</span>
    </a>

    <div class="relative flex items-center gap-6">
      {#each links as link}
        <a
          href={link.href}
          class="px-4 py-2 text-sm font-medium transition-colors hover:text-primary"
          class:text-primary={$page.url.pathname.startsWith(link.href)}
        >
          {link.label}
        </a>
      {/each}

      <div class="absolute bottom-0 h-0.5 bg-primary transition-all" 
        style="transform: translateX({$indicatorSpring.x}px); width: {$indicatorSpring.width}px;"
      />
    </div>
  </div>
</nav>

<div class="h-16" /><!-- Spacer for fixed nav -->