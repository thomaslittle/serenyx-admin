<script lang="ts">
  import { onMount } from 'svelte';
  import { supabase } from '$lib/supabase/client';
  import type { Database } from '$lib/supabase/types';

  type Match = Database['public']['Tables']['matches']['Row'];
  
  let matches: Match[] = [];
  let selectedMatchId: string | null = null;
  let overlayUrl = '';
  
  onMount(async () => {
    // Fetch active matches
    const { data } = await supabase
      .from('matches')
      .select(`
        *,
        team1:teams!team1_id(name),
        team2:teams!team2_id(name)
      `)
      .in('status', ['upcoming', 'live']);
      
    if (data) {
      matches = data;
    }
  });

  function generateOverlayUrl() {
    if (selectedMatchId) {
      const baseUrl = window.location.origin;
      overlayUrl = `${baseUrl}/overlays/match?matchId=${selectedMatchId}`;
    }
  }

  async function updateMatchScore(teamNumber: 1 | 2, increment: boolean) {
    if (!selectedMatchId) return;
    
    const match = matches.find(m => m.id === selectedMatchId);
    if (!match) return;
    
    const scoreField = teamNumber === 1 ? 'team1_score' : 'team2_score';
    const currentScore = teamNumber === 1 ? match.team1_score : match.team2_score;
    const newScore = increment ? currentScore + 1 : Math.max(0, currentScore - 1);
    
    const { error } = await supabase
      .from('matches')
      .update({ [scoreField]: newScore })
      .eq('id', selectedMatchId);
      
    if (!error) {
      matches = matches.map(m => {
        if (m.id === selectedMatchId) {
          return { ...m, [scoreField]: newScore };
        }
        return m;
      });
    }
  }

  async function updateMatchStatus(status: 'upcoming' | 'live' | 'completed') {
    if (!selectedMatchId) return;

    const { error } = await supabase
      .from('matches')
      .update({ status })
      .eq('id', selectedMatchId);

    if (!error) {
      matches = matches.map(m => {
        if (m.id === selectedMatchId) {
          return { ...m, status };
        }
        return m;
      });
    }
  }
</script>

<div class="min-h-screen bg-gray-900 p-8">
  <div class="mx-auto max-w-7xl">
    <h2 class="text-2xl font-bold text-white mb-8">Match Overlay Control</h2>
    
    <!-- Match Selection -->
    <div class="bg-gray-800 rounded-lg p-6 mb-8">
      <h3 class="text-lg font-medium text-white mb-4">Select Match</h3>
      
      <select
        bind:value={selectedMatchId}
        class="w-full bg-gray-700 text-white rounded-md px-4 py-2"
      >
        <option value="">Select a match...</option>
        {#each matches as match}
          <option value={match.id}>
            {match.team1.name} vs {match.team2.name} ({match.status})
          </option>
        {/each}
      </select>
      
      {#if selectedMatchId}
        <button
          on:click={generateOverlayUrl}
          class="mt-4 bg-red-600 text-white px-4 py-2 rounded-md hover:bg-red-500"
        >
          Generate Overlay URL
        </button>
      {/if}
    </div>
    
    {#if overlayUrl}
      <!-- Overlay URL -->
      <div class="bg-gray-800 rounded-lg p-6 mb-8">
        <h3 class="text-lg font-medium text-white mb-4">Overlay URL</h3>
        <div class="flex items-center space-x-4">
          <input
            type="text"
            readonly
            value={overlayUrl}
            class="flex-1 bg-gray-700 text-white rounded-md px-4 py-2"
          />
          <button
            on:click={() => navigator.clipboard.writeText(overlayUrl)}
            class="bg-gray-700 text-white px-4 py-2 rounded-md hover:bg-gray-600"
          >
            Copy
          </button>
        </div>
        <p class="mt-2 text-sm text-gray-400">
          Use this URL as a Browser Source in OBS
        </p>
      </div>
    {/if}
    
    {#if selectedMatchId}
      <!-- Match Controls -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
        <!-- Score Controls -->
        <div class="bg-gray-800 rounded-lg p-6">
          <h3 class="text-lg font-medium text-white mb-4">Score Controls</h3>
          
          {#if matches.length}
            {@const match = matches.find(m => m.id === selectedMatchId)}
            {#if match}
              <div class="space-y-6">
                <!-- Team 1 -->
                <div>
                  <h4 class="text-white mb-2">{match.team1.name}</h4>
                  <div class="flex items-center space-x-4">
                    <button
                      on:click={() => updateMatchScore(1, false)}
                      class="bg-gray-700 text-white px-4 py-2 rounded-md hover:bg-gray-600"
                    >
                      -
                    </button>
                    <span class="text-white text-xl font-bold">{match.team1_score}</span>
                    <button
                      on:click={() => updateMatchScore(1, true)}
                      class="bg-gray-700 text-white px-4 py-2 rounded-md hover:bg-gray-600"
                    >
                      +
                    </button>
                  </div>
                </div>
                
                <!-- Team 2 -->
                <div>
                  <h4 class="text-white mb-2">{match.team2.name}</h4>
                  <div class="flex items-center space-x-4">
                    <button
                      on:click={() => updateMatchScore(2, false)}
                      class="bg-gray-700 text-white px-4 py-2 rounded-md hover:bg-gray-600"
                    >
                      -
                    </button>
                    <span class="text-white text-xl font-bold">{match.team2_score}</span>
                    <button
                      on:click={() => updateMatchScore(2, true)}
                      class="bg-gray-700 text-white px-4 py-2 rounded-md hover:bg-gray-600"
                    >
                      +
                    </button>
                  </div>
                </div>
              </div>
            {/if}
          {/if}
        </div>

        <!-- Match Status Controls -->
        <div class="bg-gray-800 rounded-lg p-6">
          <h3 class="text-lg font-medium text-white mb-4">Match Status</h3>
          
          <div class="space-y-4">
            {#each ['upcoming', 'live', 'completed'] as status}
              {@const match = matches.find(m => m.id === selectedMatchId)}
              <button
                on:click={() => updateMatchStatus(status)}
                class="w-full rounded-md px-4 py-2 text-white
                  {match?.status === status ? 'bg-red-600 hover:bg-red-500' : 'bg-gray-700 hover:bg-gray-600'}"
              >
                {status.charAt(0).toUpperCase() + status.slice(1)}
              </button>
            {/each}
          </div>
        </div>
      </div>
    {/if}
  </div>
</div>