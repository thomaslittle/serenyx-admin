<script lang="ts">
  import { Select } from './shared';
  import { spring } from 'svelte/motion';
  
  export let value: any;
  export let items: Array<{value: any, label: string}>;
  export let placeholder = 'Select option...';
  
  const contentScale = spring(0.97, {
    stiffness: 0.1,
    damping: 0.4
  });
  
  $: contentScale.set(1);
</script>

<Select.Root bind:value>
  <Select.Trigger
    class="flex h-10 w-full items-center justify-between rounded-md border border-input bg-transparent px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
  >
    <Select.Value {placeholder} />
    <Select.Icon class="h-4 w-4 opacity-50" />
  </Select.Trigger>
  
  <Select.Portal>
    <Select.Content
      class="relative z-50 min-w-[8rem] overflow-hidden rounded-md border bg-popover text-popover-foreground shadow-md animate-in fade-in-80"
      style="transform: scale({$contentScale})"
    >
      <Select.Viewport class="p-1">
        {#each items as item}
          <Select.Item
            value={item.value}
            class="relative flex cursor-default select-none items-center rounded-sm py-1.5 px-2 text-sm outline-none focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50"
          >
            <Select.ItemText>{item.label}</Select.ItemText>
          </Select.Item>
        {/each}
      </Select.Viewport>
    </Select.Content>
  </Select.Portal>
</Select.Root>