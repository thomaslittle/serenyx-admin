<script lang="ts">
  import { Button } from './shared';
  import { createEventDispatcher } from 'svelte';
  import { spring } from 'svelte/motion';
  
  export let variant: 'default' | 'destructive' | 'outline' | 'secondary' | 'ghost' = 'default';
  export let size: 'default' | 'sm' | 'lg' | 'icon' = 'default';
  export let disabled = false;
  
  const scale = spring(1, {
    stiffness: 0.2,
    damping: 0.4
  });
  
  const dispatch = createEventDispatcher();
  
  function handlePress() {
    scale.set(0.97);
    setTimeout(() => scale.set(1), 100);
    dispatch('click');
  }
</script>

<Button.Root
  {disabled}
  class="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:opacity-50 disabled:pointer-events-none ring-offset-background
    {variant === 'default' ? 'bg-primary text-primary-foreground hover:bg-primary/90' : ''}
    {variant === 'destructive' ? 'bg-destructive text-destructive-foreground hover:bg-destructive/90' : ''}
    {variant === 'outline' ? 'border border-input hover:bg-accent hover:text-accent-foreground' : ''}
    {variant === 'secondary' ? 'bg-secondary text-secondary-foreground hover:bg-secondary/80' : ''}
    {variant === 'ghost' ? 'hover:bg-accent hover:text-accent-foreground' : ''}
    {size === 'default' ? 'h-10 py-2 px-4' : ''}
    {size === 'sm' ? 'h-9 px-3' : ''}
    {size === 'lg' ? 'h-11 px-8' : ''}
    {size === 'icon' ? 'h-10 w-10' : ''}"
  style="transform: scale({$scale})"
  on:click={handlePress}
  {...$$restProps}
>
  <slot />
</Button.Root>