<script lang="ts">
  import { page } from '$app/stores';
  import Button from '$lib/components/ui/Button.svelte';
  import { fade } from 'svelte/transition';
</script>

<div class="min-h-screen grid place-items-center p-4" in:fade>
  <div class="text-center space-y-6">
    <h1 class="text-8xl font-bold">{$page.status}</h1>
    <p class="text-xl text-muted-foreground">{$page.error?.message}</p>
    <Button href="/">Return Home</Button>
  </div>
</div>