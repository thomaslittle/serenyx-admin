<script lang="ts">
  import { onMount } from 'svelte';
  import * as Carousel from '$lib/components/ui/carousel/index.js';
  import { Input } from '$lib/components/ui/input/index.js';
  import { Button } from '$lib/components/ui/button/index.js';
  import { fade, fly } from 'svelte/transition';
  import { tweened } from 'svelte/motion';
  import { cubicOut } from 'svelte/easing';

  let timeLeft = '15:00';
  let targetTime: Date | null = null;

  let editableTexts = {
    season: '2025 SEASON 0',
    region: 'NORTH AMERICA',
    week: 'WEEK 1'
  };

  // Create dots array for the background pattern
  const dots = Array.from({ length: 240 }, (_, i) => ({
    id: i,
    delay: Math.random() * 3,
    x: (i % 20) * 96,
    y: Math.floor(i / 20) * 96
  }));

  function updateTimer() {
    if (!targetTime) return;

    const now = new Date();
    const diff = targetTime.getTime() - now.getTime();

    if (diff <= 0) {
      timeLeft = '00:00';
      return;
    }

    const minutes = Math.floor(diff / 1000 / 60);
    const seconds = Math.floor((diff / 1000) % 60);
    timeLeft = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
  }

  function handleTimeSet(e: SubmitEvent) {
    e.preventDefault();
    const formData = new FormData(e.target as HTMLFormElement);
    const hours = Number.parseInt(formData.get('hours') as string) || 0;
    const minutes = Number.parseInt(formData.get('minutes') as string) || 0;

    const target = new Date();
    target.setHours(target.getHours() + hours);
    target.setMinutes(target.getMinutes() + minutes);
    targetTime = target;
  }

  onMount(() => {
    const interval = setInterval(updateTimer, 1000);
    return () => clearInterval(interval);
  });
</script>

<div class="relative h-[1080px] w-[1920px] overflow-hidden bg-[#f5f5f5]">
  <!-- Background gradient overlay -->
  <div class="absolute inset-0 bg-gradient-to-br from-white/50 to-transparent" />

  <!-- Animated dot pattern -->
  <div class="absolute inset-0 overflow-hidden">
    {#each dots as dot (dot.id)}
      <div
        class="absolute h-1.5 w-1.5 rounded-full bg-gradient-to-b from-gray-300/30 to-gray-400/20"
        style="left: {dot.x}px; top: {dot.y}px;"
        in:fade={{
          duration: 4000,
          delay: dot.delay * 1000
        }}
        out:fade={{
          duration: 4000
        }}
      />
    {/each}
  </div>

  <!-- Main content grid -->
  <div class="relative grid h-full grid-rows-[auto_1fr_auto] py-12">
    <!-- Top section -->
    <div class="grid grid-cols-3 items-center px-16">
      <h1
        in:fly={{ x: -50, duration: 1000 }}
        class="font-system text-[72px] font-bold tracking-[-0.05em]"
      >
        SRNX
      </h1>
      <div class="flex justify-center">
        <img src="/images/logo.svg" alt="League Logo" class="h-16 w-16 opacity-90" />
      </div>
      <h1
        in:fly={{ x: 50, duration: 1000 }}
        class="font-system text-right text-[72px] font-bold tracking-[-0.05em]"
      >
        LEAGUE
      </h1>
    </div>

    <!-- Center section with sponsors and main content -->
    <div class="flex flex-col justify-center space-y-16">
      <!-- Sponsors -->
      <div class="space-y-8 text-center">
        <h2 class="text-2xl font-medium tracking-wide">PRESENTED BY:</h2>
        <div class="flex items-center justify-center gap-24">
          <img
            src="/images/sponsors/sponsor1.svg"
            alt="Sponsor 1"
            class="h-[50px] w-[100px] opacity-80"
          />
          <img
            src="/images/sponsors/sponsor2.svg"
            alt="Sponsor 2"
            class="h-[50px] w-[220px] opacity-80"
          />
          <img
            src="/images/sponsors/sponsor3.svg"
            alt="Sponsor 3"
            class="h-[50px] w-[100px] opacity-80"
          />
        </div>
      </div>

      <!-- Main display -->
      <div class="grid grid-cols-[1fr_auto_1fr] items-center gap-8 px-16">
        <div class="flex items-center justify-end">
          <span class="text-[180px] font-bold leading-none tracking-[-0.08em]">SL</span>
        </div>

        <div class="relative w-[800px]">
          <Carousel.Root class="w-full">
            <Carousel.Content>
              <Carousel.Item>
                <div class="relative h-[300px] overflow-hidden rounded-xl">
                  <img
                    src="https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Start%20Screen-on6Vi083hp8J16mtav9QvvhQ2rwg9U.png"
                    alt="Main display"
                    class="h-full w-full object-cover"
                  />
                </div>
              </Carousel.Item>
            </Carousel.Content>
          </Carousel.Root>

          <div
            in:fly={{ y: 20, duration: 1000 }}
            class="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 rounded-xl bg-black/20 px-10 py-4 backdrop-blur-sm"
          >
            <h2 class="text-[72px] font-bold tracking-wider text-white">{timeLeft}</h2>
          </div>
        </div>

        <div class="flex items-center">
          <span class="text-[180px] font-bold leading-none tracking-[-0.08em]">25</span>
        </div>
      </div>
    </div>

    <!-- Bottom section -->
    <div class="mt-auto grid grid-cols-3 px-16">
      <span
        in:fly={{ y: 20, duration: 1000, delay: 200 }}
        class="text-2xl font-medium tracking-wide"
        contenteditable="true"
        bind:textContent={editableTexts.season}
      >
        {editableTexts.season}
      </span>
      <span
        in:fly={{ y: 20, duration: 1000, delay: 300 }}
        class="text-center text-2xl font-medium tracking-wide"
        contenteditable="true"
        bind:textContent={editableTexts.region}
      >
        {editableTexts.region}
      </span>
      <span
        in:fly={{ y: 20, duration: 1000, delay: 400 }}
        class="text-right text-2xl font-medium tracking-wide"
        contenteditable="true"
        bind:textContent={editableTexts.week}
      >
        {editableTexts.week}
      </span>
    </div>
  </div>

  <!-- Timer control form -->
  <form
    on:submit|preventDefault={handleTimeSet}
    class="absolute right-4 top-4 flex gap-2 rounded-lg bg-white/80 p-2 backdrop-blur-sm"
  >
    <Input type="number" name="hours" min="0" max="23" placeholder="Hours" class="w-20" />
    <Input type="number" name="minutes" min="0" max="59" placeholder="Minutes" class="w-20" />
    <Button type="submit" variant="default" class="bg-black text-white hover:bg-gray-800">
      Set Timer
    </Button>
  </form>
</div>

<style>
  .font-system {
    font-family:
      system-ui,
      -apple-system,
      BlinkMacSystemFont,
      'Segoe UI',
      Roboto,
      Oxygen,
      Ubuntu,
      Cantarell,
      'Open Sans',
      'Helvetica Neue',
      sans-serif;
  }

  :global(.dot-animation) {
    animation: pulse 4s infinite;
  }

  @keyframes pulse {
    0% {
      opacity: 0;
      transform: scale(0);
    }
    50% {
      opacity: 0.15;
      transform: scale(1);
    }
    100% {
      opacity: 0;
      transform: scale(0);
    }
  }
</style>
