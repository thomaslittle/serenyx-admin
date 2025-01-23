<script lang="ts">
    import { onMount } from 'svelte';
    import { page } from '$app/stores';

    onMount(() => {
        console.log('[SXSERVERLOG] Callback page mounted');
        console.log('[SXSERVERLOG] URL params:', $page.url.searchParams.toString());
    });
</script>

<div>Processing login...</div>