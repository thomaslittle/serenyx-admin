<script lang="ts">
  import { spring } from 'svelte/motion';
  
  export let value: string | number;
  export let label: string;
  export let size = 'md';
  
  const scale = spring(0, {
    stiffness: 0.2,
    damping: 0.4
  });
  
  $: scale.set(1);
</script>

<div class="flex flex-col items-center"
  style="transform: scale({$scale})"
>
  <div class={`rounded-full border-4 border-primary flex items-center justify-center
    ${size === 'sm' ? 'w-16 h-16' : size === 'lg' ? 'w-32 h-32' : 'w-24 h-24'}`}
  >
    <span class="font-bold text-2xl">{value}</span>
  </div>
  <span class="mt-2 text-sm text-muted-foreground">{label}</span>
</div>