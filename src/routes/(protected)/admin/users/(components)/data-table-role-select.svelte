<script lang="ts">
  export let value: string;
  export let options: Array<{ value: string; label: string }>;
  export let onChange: (value: string) => void;
</script>

<select
  class="rounded-md bg-neutral-200 px-2 py-1 text-sm text-neutral-900 dark:bg-neutral-700 dark:text-white"
  {value}
  on:change={(e) => onChange(e.currentTarget.value)}
>
  {#each options as option}
    <option value={option.value}>{option.label}</option>
  {/each}
</select>
