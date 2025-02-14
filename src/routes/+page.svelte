<script lang="ts">
  import { useClerkContext } from 'svelte-clerk';
  import Loader from '$lib/components/ui/loader.svelte';

  const ctx = useClerkContext();
  const userId = $derived(ctx.auth.userId);
  const firstName = $derived(ctx.user?.firstName);
</script>

<main>
  <div class="relative flex min-h-screen items-center justify-center bg-white">
    <!-- Fullscreen video -->
    <video
      autoplay
      muted
      loop
      playsinline
      class="absolute inset-0 h-full w-full object-cover opacity-10"
    >
      <source src="https://cdn.serenyxleague.com/r/csvCjr.webm" type="video/webm" />
      Your browser does not support the video tag.
    </video>

    <!-- Loader overlay -->
    <a
      href="https://www.twitch.tv/serenyxleague"
      target="_blank"
      rel="noopener noreferrer"
      class="relative z-10"
    >
      <Loader width="100" height="100" className="text-white" />
    </a>
  </div>
</main>
