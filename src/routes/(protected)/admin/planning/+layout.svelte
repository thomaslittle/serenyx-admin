<script lang="ts">
  import { fade } from 'svelte/transition';
  import { page } from '$app/stores';
  
  const sections = [
    { href: '/admin/planning/broadcast-script', label: 'Broadcast Script' },
    { href: '/admin/planning/changelog', label: 'Changelog' }
  ];
</script>

<div class="space-y-8" in:fade>
  <div class="border-b">
    <nav class="flex space-x-4">
      {#each sections as section}
        <a
          href={section.href}
          class="px-3 py-2 text-sm font-medium transition-colors hover:text-primary"
          class:text-primary={$page.url.pathname === section.href}
        >
          {section.label}
        </a>
      {/each}
    </nav>
  </div>
  
  <slot />
</div>