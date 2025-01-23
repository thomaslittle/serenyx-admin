<script lang="ts">
  import { fade } from 'svelte/transition';
  import { onMount, onDestroy } from 'svelte';
  
  export let data;
  let socket;
  
  onMount(() => {
    socket = new WebSocket(`ws://${window.location.host}/ws/match`);
    socket.onmessage = (event) => {
      const update = JSON.parse(event.data);
      data.match = { ...data.match, ...update };
    };
  });
  
  onDestroy(() => socket?.close());
</script>

<div class="fixed inset-0 grid place-items-center p-8" in:fade>
  <div class="relative flex items-center gap-12">
    <div class="text-center">
      <img 
        src={data.match.team1.logo} 
        alt="" 
        class="w-32 h-32 rounded-full mb-4"
      />
      <h2 class="text-4xl font-bold">{data.match.team1.name}</h2>
      <div class="text-6xl font-bold mt-4">{data.match.team1Score}</div>
    </div>

    <div class="text-4xl font-bold text-muted-foreground">VS</div>

    <div class="text-center">
      <img 
        src={data.match.team2.logo} 
        alt="" 
        class="w-32 h-32 rounded-full mb-4"
      />
      <h2 class="text-4xl font-bold">{data.match.team2.name}</h2>
      <div class="text-6xl font-bold mt-4">{data.match.team2Score}</div>
    </div>
  </div>
</div>