<script lang="ts">
  import { cn } from '$lib/utils';
  import { buttonVariants } from '$lib/components/ui/button';
  import type { SidebarNavItem } from './types';

  export let items: SidebarNavItem[];
</script>

<nav class="grid items-start gap-2">
  {#each items as item}
    <a
      href={item.href}
      class={cn(
        buttonVariants({ variant: 'ghost' }),
        'justify-start',
        item.disabled && 'cursor-not-allowed opacity-60'
      )}
      {...item.disabled ? { 'aria-disabled': true } : {}}
    >
      {#if item.icon}
        <svelte:component this={item.icon} class="mr-2 h-4 w-4" />
      {/if}
      {item.title}
    </a>
  {/each}
</nav>
