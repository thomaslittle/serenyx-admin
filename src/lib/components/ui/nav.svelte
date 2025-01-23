<script lang="ts">
  import { page } from '$app/stores';
  
  export let links: { href: string; label: string }[] = [
    { href: '/tournaments', label: 'Tournaments' },
    { href: '/teams', label: 'Teams' },
    { href: '/stats', label: 'Statistics' }
  ];
</script>

<nav class="flex items-center justify-between p-4 bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
  <div class="flex items-center space-x-4">
    <img src="/logo.svg" alt="Serenyx" class="h-8" />
    <h1 class="text-xl font-bold">SERENYX LEAGUE</h1>
  </div>
  
  <div class="flex space-x-6">
    {#each links as link}
      <a 
        href={link.href}
        class="text-sm transition-colors hover:text-primary"
        class:text-primary={$page.url.pathname === link.href}
      >
        {link.label}
      </a>
    {/each}
  </div>
</nav>