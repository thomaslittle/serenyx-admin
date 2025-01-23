<script lang="ts">
  import AdminNav from '$lib/components/ui/AdminNav.svelte';
  import { fade } from 'svelte/transition';
</script>

<div class="min-h-screen bg-background">
  <AdminNav />
  
  <main class="container py-8" in:fade={{ duration: 150 }}>
    <slot />
  </main>
</div>