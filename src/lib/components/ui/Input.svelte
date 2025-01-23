<script lang="ts">
  export let value: string = '';
  export let type: 'text' | 'password' | 'email' | 'number' = 'text';
  export let placeholder: string = '';
  export let error: string | undefined = undefined;
  export let required = false;
</script>

<div class="relative">
  <input
    bind:value
    {type}
    {placeholder}
    {required}
    class="inline-flex h-10 w-full items-center rounded-md border border-input bg-background px-4 text-sm placeholder:text-foreground-alt/50 hover:border-dark-40 focus:outline-none focus:ring-2 focus:ring-foreground focus:ring-offset-2 focus:ring-offset-background"
  />
  
  {#if error}
    <p class="text-destructive text-sm mt-1">
      {error}
    </p>
  {/if}
</div>