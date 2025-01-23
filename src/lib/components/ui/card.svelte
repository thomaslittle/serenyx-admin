
<script lang="ts">
  import { fade } from 'svelte/transition';
  import { cn } from '$lib/utils';
  
  export let class = '';
  export let hover = false;
</script>

<div
  class={cn(
    'rounded-lg border bg-card p-4 text-card-foreground shadow transition-all duration-200',
    hover && 'hover:scale-[1.02] hover:shadow-lg',
    class
  )}
  transition:fade={{duration: 200}}
>
  <slot />
</div>
