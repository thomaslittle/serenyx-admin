<script lang="ts">
  import { Checkbox } from '$lib/components/ui/checkbox';
  import { Button } from '$lib/components/ui/button';
  import ArrowUpDown from 'lucide-svelte/icons/arrow-up-down';

  export let type: 'checkbox' | 'email-header' | 'select' | 'text';
  export let data: any;
</script>

{#if type === 'checkbox'}
  <div class="px-1">
    <Checkbox
      checked={data.checked}
      on:change={(e) => data.onCheckedChange(!!e.currentTarget.checked)}
    />
  </div>
{:else if type === 'email-header'}
  <Button variant="ghost" on:click={data.onClick} class="flex items-center gap-2">
    Email
    <ArrowUpDown class="h-4 w-4" />
  </Button>
{:else if type === 'select'}
  <select
    class="rounded-md bg-neutral-200 px-2 py-1 text-sm text-neutral-900 dark:bg-neutral-700 dark:text-white"
    value={data.value}
    on:change={(e) => data.onChange(e.currentTarget.value)}
  >
    {#each data.options as option}
      <option value={option.value}>{option.label}</option>
    {/each}
  </select>
{:else}
  <div class={data.class}>{data.text}</div>
{/if}
